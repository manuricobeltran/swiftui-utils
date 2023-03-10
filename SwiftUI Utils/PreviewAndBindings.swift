//
//  PreviewAndBindings.swift
//  SwiftUI Utils
//
//  Created by Manu Rico on 30/12/22.
//

import SwiftUI

///
/// Use fully working bindings with previews
///
///
/// ToDo List
///

private struct TodoListView: View {
    @State var todos: [Todo]
    
    var body: some View {
        NavigationStack {
            List($todos, id: \.title) { $todo in
                TodoRowView(todo: $todo)
            }
            .listStyle(.plain)
            .navigationTitle("My tasks")
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todos: Todo.samples)
    }
}

private struct TodoRowView: View {
    @Binding var todo: Todo
    
    var body: some View {
        Toggle(isOn: $todo.completed) {
            Text(todo.title)
                .strikethrough(todo.completed)
        }
    }
}

// MARK: - Preview with bindings
///
/// Preview
///

struct TodoRowViewOption1_Previews: PreviewProvider {
    private struct Container: View {
        @State var todo = Todo.sample
        var body: some View {
            TodoRowView(todo: $todo)
        }
    }
    
    static var previews: some View {
        Container()
    }
}
// MARK: - Stateful Preview Struct

///
/// StatefulPreviewContainer
///

private struct StatefulPreviewContainer<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    var body: some View {
        content($value)
    }
    
    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}

struct TodoRowViewOption2_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewContainer(Todo.sample) { binding in
            TodoRowView(todo: binding)
        }
    }
}
// MARK: -

///
/// Model
///

private struct Todo {
    let title: String
    var completed: Bool = false
    
    static var sample:Todo {
        samples[.zero]
    }
    
    static var samples: [Todo] {
        [
            .init(title: "Todo Sample 1"),
            .init(title: "Todo Sample 2")
        ]
    }
}
