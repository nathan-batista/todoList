//
//  EmptyContentView.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 06/02/23.
//

import SwiftUI

struct EmptyContentView: View {
    
    enum Constants {
        static let empty = "Oh no! It seems your {} is empty."
    }
    
    let content: String
    
    init(content: String = "TodoList") {
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text(Constants.empty.replacingOccurrences(of: "{}", with: content))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct EmptyContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyContentView()
    }
}
