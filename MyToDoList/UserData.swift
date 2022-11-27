//
//  UserData.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 22/11/2022.
//

import Foundation
import UserNotifications

var encoder = JSONEncoder()
var decoder = JSONDecoder()

let notificationContent = UNMutableNotificationContent()


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
            self.ToDoList.append(SingleToDo(title: item.title, dueDate: item.dueDate, isChecked: item.isChecked, isFavorite: item.isFavorite, id: self.count))
            count += 1
        }
    }
    
    func check(id: Int) {
        self.ToDoList[id].isChecked.toggle()
        
        self.dataStore()
    }
    
    func add(data: SingleToDo) {
        self.ToDoList.append(SingleToDo(title: data.title, dueDate: data.dueDate, isFavorite: data.isFavorite, id:self.count))
        self.count += 1
        
        self.sort()
        self.dataStore()
        
        self.sendNotification(id: self.ToDoList.count-1)
    }
    
    func edit(id: Int, data: SingleToDo) {
        self.withdrawNotification(id: id)
        
        self.ToDoList[id].title = data.title
        self.ToDoList[id].dueDate = data.dueDate
        self.ToDoList[id].isChecked = false
        self.ToDoList[id].isFavorite = data.isFavorite
        
        self.sort()
        self.dataStore()
        
        self.sendNotification(id: id)
    }
    
    func delete(id:Int) {
        self.withdrawNotification(id: id)
        self.ToDoList[id].deleted = true
        self.sort()
        self.dataStore()
    }
    
    func sendNotification(id: Int) {
        notificationContent.title = self.ToDoList[id].title
        notificationContent.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.ToDoList[id].dueDate.timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: self.ToDoList[id].title + self.ToDoList[id].dueDate.description + String(self.ToDoList[id].id), content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func withdrawNotification(id: Int){
        let todoIdentifier: String = String(self.ToDoList[id].title + self.ToDoList[id].dueDate.description + String(self.ToDoList[id].id))
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [todoIdentifier])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [todoIdentifier])
        
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
    
    var isFavorite: Bool = false
    
    var deleted = false
    
    var id: Int = 0
}



