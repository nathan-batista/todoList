//
//  TodoListHomeView.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import SwiftUI

struct TodoListHomeView: View {
    
    enum Constants {
        static let navigationTitle = "Todo List"
    }
    
    @ObservedObject var viewModel: TodoListViewModel
    
    init(viewModel: TodoListViewModel =  TodoListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemBackground)
                    .ignoresSafeArea()
                LoadingContentView(state: $viewModel.state) {
                    EmptyContentView(content: Constants.navigationTitle)
                        .opacity(viewModel.todoItems.isEmpty ? 1 : 0)
                    List(viewModel.todoItems, id: \.id) { todo in
                        makeContentForItem(todo)
                            .swipeActions(edge: .trailing){
                                Button {
                                    viewModel.deleteItem(id: todo.id)
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color(UIColor.tertiarySystemBackground))
                    }
                    .searchable(text: $viewModel.searchableText, prompt: "Search an Todo Item")
                    .onSubmit(of: .search, {
                        self.viewModel.fetch()
                    })
                    .refreshable {
                        self.viewModel.refresh()
                    }
                    .opacity(viewModel.todoItems.isEmpty ? 0 : 1)
                }
            }
            .navigationTitle(Constants.navigationTitle)
            .toolbar {
                Button {
                    self.viewModel.showAddTodo.toggle()
                } label: {
                    Text("+")

                }
            }
            .sheet(isPresented: $viewModel.showAddTodo) {
                AddTodoView(viewModel: self.viewModel.makeAddViewModel())
            }
        }
    }
    
    private func makeContentForItem(_ item: TodoModel) -> NavigationLink<Text, TodoDetailsView> {
        NavigationLink {
            TodoDetailsView(item: item)
        } label: {
            Text(item.title)
        }
    }
}

struct TodoListHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListHomeView()
    }
}

extension View {
    @ViewBuilder func searchable(showSearch: Bool, text: Binding<String>, prompt: String = "") -> some View {
        if showSearch {
            self.searchable(text: text, prompt: prompt)
        } else {
            self
        }
    }
}
