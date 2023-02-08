//
//  MockTodoListRepository.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import Foundation
import Combine

class MockTodoListRepository: TodoListRepositoryProtocol {
    
    var items: [TodoModel] = []
    
    func fetchItems() -> AnyPublisher<[TodoModel], Error> {
        return Future<[TodoModel], Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let items = self?.items else {
                    promise(.failure(HTTPError.invalidURL))
                    return
                }
                promise(.success(items))
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchItem(id: String) -> AnyPublisher<TodoModel, Error> {
        return Future<TodoModel, Error> { [weak self] promise in
            if let selectedItem = self?.items.first(where: {$0.id == id}) {
                promise(.success(selectedItem))
                return
            }
            promise(.failure(HTTPError.notFound))
        }.eraseToAnyPublisher()
    }
    
    func addItem(item: ToSaveTodoModel) -> AnyPublisher<[TodoModel], Error> {
        return Future<[TodoModel], Error> {[weak self] promise in
            let todoItem = TodoModel()
            todoItem.title = item.title
            todoItem.creationDate = item.creationDate
            todoItem.todoDescription = item.description
            self?.items.append(todoItem)
            guard let items = self?.items else {
                promise(.failure(HTTPError.invalidURL))
                return
            }
            promise(.success(items))
        }.eraseToAnyPublisher()
    }
    
    func removeItem(id: String) -> AnyPublisher<[TodoModel], Error> {
        return Future<[TodoModel], Error> { [weak self] promise in
            guard var items = self?.items else {
                promise(.failure(HTTPError.notFound))
                return
            }
            items = items.filter({$0.id != id})
            self?.items = items
            promise(.success(items))
        }.eraseToAnyPublisher()
    }
    
}
