//
//  TextView.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 06/02/23.
//

import SwiftUI
import UIKit

//Adapted from: https://stackoverflow.com/questions/27652227/add-placeholder-text-inside-uitextview-in-swift

struct TextView: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let configurator: (UITextView) -> Void

    final class Coordinator: NSObject, UITextViewDelegate {
        let parent: TextView

        init(parent: TextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            if textView.text != parent.text {
                parent.text = textView.text
            }
        }
                
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
            }
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

            // Combine the textView text and the replacement text to
            // create the updated text string
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

            // If updated text view will be empty, add the placeholder
            // and set the cursor to the beginning of the text view
            if updatedText.isEmpty {

                textView.text = parent.placeholder
                textView.textColor = UIColor.placeholderText

                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }

            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, set
            // the text color to black then set its text to the
            // replacement string
             else if textView.textColor == UIColor.placeholderText && !text.isEmpty {
                textView.textColor = UIColor.label
                textView.text = text
            }

            // For every other case, the text should change with the usual
            // behavior...
            else {
                return true
            }

            // ...otherwise return false since the updates have already
            // been made
            return false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        self.configurator(view)
        view.delegate = context.coordinator
        view.text = placeholder
        view.textColor = UIColor.placeholderText
        view.selectedTextRange = view.textRange(from: view.beginningOfDocument, to: view.beginningOfDocument)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if !text.isEmpty {
            uiView.text = text
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: .constant(""), placeholder: "OI") {
            $0.font = UIFont.preferredFont(forTextStyle: .body)
        }
    }
}
