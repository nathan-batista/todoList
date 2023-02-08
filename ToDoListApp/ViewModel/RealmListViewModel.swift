//
//  TodoListViewModel.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import Foundation
import Combine
import RealmSwift

class RealmListViewModel: NSObject, ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var searchableText = ""
    @Published var state = ViewModelState.idle
    @ObservedResults(TodoModelRealm.self) var todoRealmItems
    @Published var showAddTodo = false
    
    override init() {
        super.init()
    }
        
    func deleteItem(_ todo: TodoModelRealm) {
        self.$todoRealmItems.remove(todo)
    }
    
    func addItem(item: ToSaveTodoModel) {
        let todo = TodoModelRealm()
        todo.title = item.title
        todo.todoDescription = item.description
        $todoRealmItems.append(todo)
    }
    
    func makeAddViewModel() -> RealmAddTodoViewModel {
        let viewModel = RealmAddTodoViewModel(delegate: self)
        return viewModel
    }
    
}

extension RealmListViewModel: CreateTodoDelegate {
    func didTapCreate(item: ToSaveTodoModel) {
        self.addItem(item: item)
    }
}
