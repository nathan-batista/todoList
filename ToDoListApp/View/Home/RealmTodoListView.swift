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
    
    @ObservedObject var viewModel = RealmListViewModel()
    
    var itemsList: some View {
        List {
            ForEach(self.viewModel.todoRealmItems) { todo in
                NavigationLink(value: todo) {
                    makeContentForItem(todo)
                }
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: self.viewModel.deleteItem(_:))
        }
        .navigationDestination(for: TodoModelRealm.self, destination: { selectedTodo in
            TodoDetailsView(item: selectedTodo)
        })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if self.viewModel.todoRealmItems.isEmpty {
                    EmptyContentView(content: Constants.navigationTitle)
                } else {
                    itemsList
                }
            }
            .searchable(text: self.$viewModel.searchableText,
                        collection: self.viewModel.$todoRealmItems,
                        keyPath: \.title,
                        prompt: "Search an Todo Item") {
                ForEach(self.viewModel.todoRealmItems) { itemsFiltered in
                    Text(itemsFiltered.title).searchCompletion(itemsFiltered.title)
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle(Constants.navigationTitle)
            .toolbar {
                Button {
                    viewModel.showAddTodo.toggle()
                } label: {
                    Text("+")

                }
            }
            .sheet(isPresented: $viewModel.showAddTodo) {
                RealmAddTodoView(viewModel: viewModel.makeAddViewModel())
            }
        }
    }
    
    private func makeContentForItem(_ item: TodoItem) -> Text {
            Text(item.title)
    }
}

struct RealmTodoListHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RealmTodoListHomeView()
    }
}

