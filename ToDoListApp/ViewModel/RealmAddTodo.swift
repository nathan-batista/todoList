//
//  RealmAddTodo.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 08/02/23.
//

import RealmSwift
import Combine

class RealmAddTodoViewModel: ObservableObject {
    @Published var todoName: String = ""
    @Published var todoDescription: String = ""
    
    weak var delegate: CreateTodoDelegate?
    
    init(delegate: CreateTodoDelegate?) {
        self.delegate = delegate
    }
    
    func create() {
        let toSaveItem = ToSaveTodoModel(title: self.todoName, description: self.todoDescription)
        self.delegate?.didTapCreate(item: toSaveItem)
    }
}
