//
//  AddTodoView.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 06/02/23.
//

import SwiftUI
import RealmSwift

struct RealmAddTodoView: View {
    
    enum Constants {
        static let textViewPlaceholder = "Write here your task description"
        static let chooseName = "Choose a name"
        static let namePlaceholder = "Write here your task name"
        static let descriptionTitle = "Write a description"
        static let navigationTitle = "Create"
    }
        
    @Environment(\.dismiss) var dismiss
    @Environment(\.realm) var realm
    
    @State var name = ""
    @State var description = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(Constants.chooseName)
                    TextField(Constants.namePlaceholder, text: self.$name)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.sentences)
                }
                .padding(.horizontal, 16)
                VStack(alignment: .leading, spacing: 4) {
                    Text(Constants.descriptionTitle)
                    TextView(text: self.$description, placeholder: Constants.textViewPlaceholder) {
                        $0.cornerRadius = 4
                        $0.borderColor = UIColor.systemGray5
                        $0.borderWidth = 1
                        $0.font = UIFont.preferredFont(forTextStyle: .body)
                    }
                    .frame(height: 200)
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Constants.navigationTitle)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        let todo = TodoModelRealm()
                        todo.todoDescription = self.description
                        todo.title = self.name
                        try? realm.write({
                            realm.add(todo)
                        })
                        dismiss()
                    } label: {
                        Text(Constants.navigationTitle)
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
            }
        }
        
    }
}
