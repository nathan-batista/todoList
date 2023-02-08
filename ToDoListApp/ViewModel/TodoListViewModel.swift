//
//  TodoListViewModel.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import Foundation
import Combine

enum ViewModelState {
    case loading
    case idle
    case refresh
}

class TodoListViewModel: NSObject, ObservableObject {
    
    let repo: TodoListRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    @Published var searchableText = ""
    @Published var state = ViewModelState.idle
    @Published var todoItems = [TodoModel]()
    @Published var showAddTodo = false
    
    init(repo: TodoListRepositoryProtocol = MockTodoListRepository()){
        self.repo = repo
    }
    
    func fetch() {
        self.state = .loading
        self.getEntitiesFromRepo()
    }
    
    private func getEntitiesFromRepo() {
        self.repo.fetchItems().sink(receiveCompletion: { _ in
            return
        }, receiveValue: {[weak self] decodedItem in
            self?.todoItems = decodedItem
            self?.state = .idle
        }).store(in: &cancellables)
    }
    
    func fetchItem(id: String) {}
    
    func deleteItem(id: String) {
        self.repo.removeItem(id: id).sink(receiveCompletion: { _ in
            return
        }, receiveValue: {[weak self] decodedItem in
            self?.todoItems = decodedItem
        }).store(in: &cancellables)
    }
    
    func addItem(item: ToSaveTodoModel) {
        self.repo.addItem(item: item).sink(receiveCompletion: { _ in
            return
        }, receiveValue: { [weak self] decodedItem in
            self?.todoItems = decodedItem
        }).store(in: &cancellables)
    }
    
    func refresh() {
        self.state = .refresh
        self.getEntitiesFromRepo()
    }
    
    func makeAddViewModel() -> AddTodoViewModel {
        let viewModel = AddTodoViewModel(delegate: self)
        return viewModel
    }
    
    
}

extension TodoListViewModel: CreateTodoDelegate {
    func didTapCreate(item: ToSaveTodoModel) {
        self.addItem(item: item)
    }
}
