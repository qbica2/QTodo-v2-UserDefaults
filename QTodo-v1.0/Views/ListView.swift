//
//  ListView.swift
//  QTodo-v1.0
//
//  Created by Mehmet Kubilay Akdemir on 14.06.2023.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack{
            if listViewModel.todos.isEmpty {
                EmptyListView()
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.8)))
            } else {
                List {
                    ForEach(listViewModel.todos) { todo in
                        TodoView(todo: todo)
                            .swipeActions {
                                Button(role: .destructive) {
                                    listViewModel.deleteTodo(todo: todo)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    listViewModel.toggleTodo(todo: todo)
                                }
                            }
                    }
                    .onMove(perform: listViewModel.moveTodos)
                    .padding(.vertical, 5)
                }
                .listStyle(.grouped)
            }
        }
        
        .navigationTitle("QTodo v1.0")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddTodoView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .tint(.primary)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }

    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
