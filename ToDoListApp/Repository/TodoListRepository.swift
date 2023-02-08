//
//  TodoListRepository.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import Foundation
import Combine


//class TodoListRepository: TodoListRepositoryProtocol {
//    
//    let baseURL = ""
//    let service = NetworkService()
//
//    func fetchItems() -> AnyPublisher<[TodoModel], Error> {
//        return self.service.makeRequest(urlString: baseURL, method: .GET)
//    }
//
//    func fetchItem(id: String) -> AnyPublisher<TodoModel, Error> {
//        let itemURL = "\(baseURL)/\(id)"
//        return self.service.makeRequest(urlString: itemURL)
//    }
//
//    func addItem(item: ToSaveTodoModel) -> AnyPublisher<[TodoModel], Error> {
//        let encoder = JSONEncoder()
//        let itemData = try? encoder.encode(item)
//        return self.service.makeRequest(urlString: self.baseURL, method: .POST, body: itemData)
//    }
//
//    func removeItem(id: String) -> AnyPublisher<[TodoModel], Error> {
//        let itemURL = "\(baseURL)/\(id)"
//        return self.service.makeRequest(urlString: itemURL, method: .DELETE)
//    }
//
//}
