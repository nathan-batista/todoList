//
//  TodoListHomeView.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import SwiftUI
import RealmSwift

struct RealmTodoListHomeView: View {
    
    enum Constants {
        static let navigationTitle = "Todo List"
    }
        
    @ObservedResults(TodoModelRealm.self) var todos
    @State var showAdd = false
    
    var body: some View {
        NavigationView {
            ZStack {
                EmptyContentView(content: Constants.navigationTitle)
                    .opacity(todos.isEmpty ? 1 : 0)
                List {
                    ForEach(todos) { todo in
                        makeContentForItem(todo)
                            .listRowSeparator(.hidden)
                    }.onDelete(perform: $todos.remove)
                }
                .opacity(todos.isEmpty ? 0 : 1)
                
            }
            .navigationTitle(Constants.navigationTitle)
            .toolbar {
                Button {
                    showAdd.toggle()
                } label: {
                    Text("+")

                }
            }
            .sheet(isPresented: $showAdd) {
                RealmAddTodoView()
            }
        }
    }
    
    private func makeContentForItem(_ item: TodoItem) -> NavigationLink<Text, TodoDetailsView> {
        NavigationLink {
            TodoDetailsView(item: item)
        } label: {
            Text(item.title)
        }
    }
}

struct RealmTodoListHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RealmTodoListHomeView()
    }
}

