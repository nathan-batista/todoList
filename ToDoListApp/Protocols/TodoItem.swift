//
//  TodoItem.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 08/02/23.
//

import Foundation

protocol TodoItem {
    var title: String {get set}
    var todoDescription: String {get set}
    var creationDate: Date {get set}
}
