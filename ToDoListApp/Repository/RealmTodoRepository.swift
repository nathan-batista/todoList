////
////  RealmTodoRepository.swift
////  ToDoListApp
////
////  Created by Nathan Batista on 06/02/23.
////
//
//import Foundation
//import Combine
//import RealmSwift
//
//class RealmTodoListRepository: TodoListRepositoryProtocol {
//
//    let realm = try! Realm()
//
//    init() {}
//
//    func fetchItems() -> AnyPublisher<[TodoModel], Error> {
//        return Future<[TodoModel], Error> { [weak self] promise in
//            guard let items = self?.realm.objects(TodoModel.self) else { promise(.failure(HTTPError.invalidURL))
//                return
//            }
//            promise(.success(Array(items)))
//        }.eraseToAnyPublisher()
//    }
//
//    func fetchItem(id: String) -> AnyPublisher<TodoModel, Error> {
//        return Future<TodoModel, Error> { [weak self] promise in
//            guard let item = self?.realm.objects(TodoModel.self).where({$0.id == id }),
//                    let chosenItem = item.first else {
//                promise(.failure(HTTPError.notFound))
//                return
//            }
//            promise(.success(chosenItem))
//        }.eraseToAnyPublisher()
//    }
//
//    func addItem(item: ToSaveTodoModel) -> AnyPublisher<[TodoModel], Error> {
//        return Future<[TodoModel], Error> {[weak self] promise in
//            let todoItem = TodoModel()
//            todoItem.title = item.title
//            todoItem.creationDate = item.creationDate
//            todoItem.todoDescription = item.description
//            try! self?.realm.write({
//                self?.realm.add(todoItem)
//            })
//            guard let items: [TodoModel] = self?.realm.objects(TodoModel.self).compactMap({ $0 }) else {
//                promise(.failure(HTTPError.notFound))
//                return
//            }
//            promise(.success(items))
//        }.eraseToAnyPublisher()
//    }
//
//    func removeItem(id: String) -> AnyPublisher<[TodoModel], Error> {
//        return Future<[TodoModel], Error> { [weak self] promise in
//            try! self?.realm.write({
//                if let items = self?.realm.objects(TodoModel.self).where({ $0.id == id }) {
//                    self?.realm.delete(items)
//                }
//            })
//            guard let item: [TodoModel] = self?.realm.objects(TodoModel.self).compactMap({$0}) else {
//                promise(.failure(HTTPError.notFound))
//                return
//            }
//            promise(.success(item))
//        }.eraseToAnyPublisher()
//    }
//
//}
