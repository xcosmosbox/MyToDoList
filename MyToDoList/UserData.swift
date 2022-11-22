//
//  UserData.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 22/11/2022.
//

import Foundation

struct SingleToDo: Identifiable {
    var title: String = ""
    var dueDate: Date = Date()
    var isChecked: Bool = false
    
    var id: Int = 0
}



