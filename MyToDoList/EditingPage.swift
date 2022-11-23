//
//  EditingPage.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 23/11/2022.
//

import SwiftUI

struct EditingPage: View {
    
    @EnvironmentObject var userData: ToDo
    
    @State var title: String = ""
    @State var dueDate: Date = Date()
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(content: {
                    TextField("ToDo Content", text: self.$title)
                    DatePicker(selection: self.$dueDate, label: { Text("Due Date") })
                }, header: {
                    Text("To Do")
                })
                
                Section{
                    Button(action: {
                        self.userData.add(data: SingleToDo(title:self.title, dueDate:self.dueDate))
                    }, label: {Text("Confirm")})
                    
                    Text("Cancle")
                }
                
            }
            
        }
    }
}

struct EditingPage_Previews: PreviewProvider {
    static var previews: some View {
        EditingPage()
    }
}
