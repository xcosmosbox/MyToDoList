//
//  UserData.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 22/11/2022.
//

import Foundation

var encoder = JSONEncoder()
var decoder = JSONDecoder()


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
            self.ToDoList.append(SingleToDo(title: item.title, dueDate: item.dueDate, isChecked: item.isChecked, id: self.count))
            count += 1
        }
    }
    
    func check(id: Int) {
        self.ToDoList[id].isChecked.toggle()
        
        self.dataStore()
    }
    
    func add(data: SingleToDo) {
        self.ToDoList.append(SingleToDo(title: data.title, dueDate: data.dueDate, id:self.count))
        self.count += 1
        
        self.sort()
        self.dataStore()
    }
    
    func edit(id: Int, data: SingleToDo) {
        self.ToDoList[id].title = data.title
        self.ToDoList[id].dueDate = data.dueDate
        self.ToDoList[id].isChecked = false
        
        self.sort()
        self.dataStore()
    }
    
    func delete(id:Int) {
        self.ToDoList[id].deleted = true
        self.sort()
        self.dataStore()
    }
    
    func sort() {
        self.ToDoList.sort(by: {(card1,card2) in
            return card1.dueDate.timeIntervalSince1970 < card2.dueDate.timeIntervalSince1970
        })
        for i in 0..<self.ToDoList.count{
            self.ToDoList[i].id = i
        }
    }
    
    func dataStore() {
        let dataStored = try! encoder.encode(self.ToDoList)
        UserDefaults.standard.set(dataStored, forKey: "MyToDoList")
    }
    
    
}

// ToDo card data
struct SingleToDo: Identifiable, Codable {
    var title: String = ""
    var dueDate: Date = Date()
    var isChecked: Bool = false
    
    var deleted = false
    
    var id: Int = 0
}



