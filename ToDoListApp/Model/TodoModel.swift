//
//  File.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import Foundation
import RealmSwift

class TodoModel: Identifiable, Equatable, TodoItem, Codable {
    static func == (lhs: TodoModel, rhs: TodoModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String = UUID().uuidString
    var title: String = ""
    var todoDescription: String = ""
    var creationDate: Date = Date()
    
    init(title: String = "",
         todoDescription: String = "",
         creationDate: Date = Date()) {
        self.title = title
        self.todoDescription = todoDescription
        self.creationDate = creationDate
    }
    
    convenience init(toSaveModel: ToSaveTodoModel) {
        self.init(title: toSaveModel.title, todoDescription: toSaveModel.description, creationDate: toSaveModel.creationDate)
    }
}

class ToSaveTodoModel: Codable {
    var title = ""
    var description = ""
    var creationDate = Date()
    
    init(title: String = "",
         description: String = "",
         creationDate: Date = Date()) {
        self.title = title
        self.description = description
        self.creationDate = creationDate
    }
}
