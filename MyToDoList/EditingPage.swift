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
    @State var isFavorite: Bool = false
    
    var id: Int? = nil
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView{
            Form{
                Section(content: {
                    TextField("ToDo Content", text: self.$title)
                    DatePicker(selection: self.$dueDate, label: { Text("Due Date") })
                }, header: {
                    Text("To Do")
                })
                
                Section(content: {
                    Toggle(isOn: self.$isFavorite, label: {
                        Image(systemName: "star.circle")
                            .imageScale(.large)
                            .foregroundColor(.yellow)
                    })
                }, header: {
                    Text("Save to favorite")
                })
                
                Section{
                    Button(action: {
                        if(self.id == nil){
                            self.userData.add(data: SingleToDo(title:self.title, dueDate:self.dueDate, isFavorite: self.isFavorite))
                        }
                        else{
                            self.userData.edit(id:self.id!,data: SingleToDo(title:self.title, dueDate:self.dueDate, isFavorite: self.isFavorite))
                        }
                        
                        self.presentation.wrappedValue.dismiss()
                    }, label: {Text("Confirm")})
                    
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }, label: {Text("Cancle")})
                    
                    
                }
                
            }
            .navigationTitle(Text("Addition"))
            
        }
    }
}

struct EditingPage_Previews: PreviewProvider {
    static var previews: some View {
        EditingPage()
    }
}
