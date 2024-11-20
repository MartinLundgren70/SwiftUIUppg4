//
//  ContentView.swift
//  TodoListUppg4
//
//  Created by Martin Lundgren on 2024-11-20.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var todoItems: [TodoItem]
    @Environment(\.modelContext) private var context
    @State private var newTaskTitle: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Ny uppgift...", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTask) {
                        Text("Lägg till")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()

                List {
                    ForEach(sortedTodoItems) { item in
                        HStack {
                            Text(item.title)
                                .strikethrough(item.isDone, color: .gray)
                                .foregroundColor(item.isDone ? .gray : .black)
                            Spacer()
                            if item.isDone {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                            }
                        }
                        .contentShape(Rectangle()) // Gör hela raden klickbar
                        .onTapGesture {
                            toggleTask(item)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .navigationTitle("Att Göra")
            }
        }
    }

    private func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        let newItem = TodoItem(title: newTaskTitle)
        context.insert(newItem)
        try? context.save()
        newTaskTitle = ""
    }

    private func toggleTask(_ item: TodoItem) {
        item.isDone.toggle()
        try? context.save()
    }

    private func deleteTask(at offsets: IndexSet) {
        // Mappa tillbaka till original index
        let itemsToDelete = offsets.map { sortedTodoItems[$0] }
        
        for item in itemsToDelete {
            context.delete(item) // Delete the actual item from the model
        }
        try? context.save()
    }

    var sortedTodoItems: [TodoItem] {
        todoItems.sorted { !$0.isDone && $1.isDone }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}

