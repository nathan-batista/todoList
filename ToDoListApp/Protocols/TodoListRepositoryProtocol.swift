//
//  TodoListRepositoryProtocol.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import Foundation
import Combine

protocol TodoListRepositoryProtocol {    
    func fetchItems() -> AnyPublisher<[TodoModel], Error>
    func fetchItem(id: String) -> AnyPublisher<TodoModel, Error>
    func addItem(item: ToSaveTodoModel) -> AnyPublisher<[TodoModel], Error>
    func removeItem(id: String) -> AnyPublisher<[TodoModel], Error>
}
