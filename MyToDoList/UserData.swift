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
    
    func add(data: SingleToDo) {
        self.ToDoList.append(SingleToDo(title: data.title, dueDate: data.dueDate, id:self.count))
        self.count += 1
        
        self.sort()
    }
    
    func edit(id: Int, data: SingleToDo) {
        self.ToDoList[id].title = data.title
        self.ToDoList[id].dueDate = data.dueDate
        self.ToDoList[id].isChecked = false
        
        self.sort()
    }
    
    func delete(id:Int) {
        self.ToDoList[id].deleted = true
        self.sort()
    }
    
    func sort() {
        self.ToDoList.sort(by: {(card1,card2) in
            return card1.dueDate.timeIntervalSince1970 < card2.dueDate.timeIntervalSince1970
        })
        for i in 0..<self.ToDoList.count{
            self.ToDoList[i].id = i
        }
    }
    
    
}

// ToDo card data
struct SingleToDo: Identifiable {
    var title: String = ""
    var dueDate: Date = Date()
    var isChecked: Bool = false
    
    var deleted = false
    
    var id: Int = 0
}



