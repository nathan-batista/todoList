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
    
    var body: some View {
        NavigationView {
            ZStack {
                EmptyContentView(content: Constants.navigationTitle)
                    .opacity(viewModel.todoRealmItems.isEmpty ? 1 : 0)
                List {
                    ForEach(viewModel.todoRealmItems) { todo in
                        makeContentForItem(todo)
                            .listRowSeparator(.hidden)
                    }.onDelete(perform: self.viewModel.deleteItem(_:))
                }
                .opacity(viewModel.todoRealmItems.isEmpty ? 0 : 1)
                
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

