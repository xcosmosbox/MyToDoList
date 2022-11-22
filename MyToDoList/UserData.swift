//
//  UserData.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 22/11/2022.
//

import Foundation

/**
 Using ToDo class to store card data and to inject SingleCardView
 @protocol: Using 'ObservableObject' protocol enables the compiler to  observe the ToDo class
 @annotation: Using '@Published' annotation enables the compiler to synchronize the value of a variable asynchronously
 */
class ToDo: ObservableObject{
    @Published var ToDoList: [SingleToDo]
    var count = 0
    
    init() {
        self.ToDoList = []
    }
    init(data: [SingleToDo]) {
        self.ToDoList = []
        for item in data{
            self.ToDoList.append(SingleToDo(title: item.title, dueDate: item.dueDate, id: self.count))
            count += 1
        }
    }
    
    func check(id: Int) {
        self.ToDoList[id].isChecked.toggle()
    }
    
}

// ToDo card data
struct SingleToDo: Identifiable {
    var title: String = ""
    var dueDate: Date = Date()
    var isChecked: Bool = false
    
    var id: Int = 0
}



