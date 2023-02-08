//
//  TodoDetailsView.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import SwiftUI

struct TodoDetailsView: View {
    let item: TodoItem
    
    let dateFormatter: DateFormatter  = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 4) {
                Text(item.title)
                    .font(.title3)
                    .fontWeight(.bold)
                Text("-")
                    .fontWeight(.bold)
                Text(dateFormatter.string(from: item.creationDate))
                    .fontWeight(.semibold)
                    .font(.body)
                    .foregroundColor(.secondary)
                Spacer()
            }
            Text(item.todoDescription)
            Spacer()
        }
        .padding()
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TodoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailsView(item: TodoModel())
    }
}
