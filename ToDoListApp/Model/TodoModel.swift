//
//  File.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import Foundation
import RealmSwift

class TodoModel: Identifiable, Equatable, TodoItem {
    static func == (lhs: TodoModel, rhs: TodoModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String = UUID().uuidString
    var title: String = ""
    var todoDescription: String = ""
    var creationDate: Date = Date()
}

class TodoModelRealm: Object, ObjectKeyIdentifiable, TodoItem {
    static func == (lhs: TodoModelRealm, rhs: TodoModelRealm) -> Bool {
        lhs.id == rhs.id
    }
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var todoDescription: String = ""
    @Persisted var creationDate: Date = Date()
    
}

//class TodoModelGroup: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var items = RealmSwift.List<TodoModelRealm>()
//
//}

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
