//
//  ContentView.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 20/11/2022.
//

import SwiftUI

func initUserData() -> [SingleToDo] {
    var output: [SingleToDo] = []
    if let dataStored = UserDefaults.standard.object(forKey: "MyToDoList") as? Data{
        let data = try! decoder.decode([SingleToDo].self, from: dataStored)
        for item in data{
            if (!item.deleted){
                output.append(SingleToDo(title: item.title, dueDate: item.dueDate, isChecked: item.isChecked, id: output.count))
            }
        }
    }
    return output
}

struct ContentView: View {
    
    // Using '@ObservedObject' annotation to asynchronouse value of 'isChecked' variable
    @ObservedObject var userData: ToDo = ToDo(data: initUserData())
    
    @State var showEditingPage = false
    @State var editingMode = false
    
    @State var selection: [Int] = []
    
    
    var body: some View{
        ZStack{
            NavigationView{
                /** Using ScrollView to implement scroll effect
                        @param .vertical : vertical effect
                        @param showsIndicators: show indicator -> Bool
                 */
                ScrollView(.vertical, showsIndicators: true){
                    VStack{
                        ForEach(self.userData.ToDoList){item in
                            if(!item.deleted){
                                SingleCardView(index:item.id)
                                    .environmentObject(self.userData)
                                    .padding(.top)
                                    .padding(.horizontal)
                            }
                            
                        }
                    }
                    
                }
                .navigationTitle("Reminder")
                .toolbar(content: {
                    EditingButton(editingMode: self.$editingMode)
                })
            }
            
            
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button(action: {
                        self.showEditingPage = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70)
                            .foregroundColor(.blue)
                            .padding(.trailing)
                    }
                    .sheet(isPresented: self.$showEditingPage, content: {
                        EditingPage().environmentObject(self.userData)
                    })
                    
                    
                    
                    
                }
            }
        }
        
        
        
    }

}

struct EditingButton:View {
    @Binding var editingMode: Bool
    var body: some View{
        Button(action: {
            self.editingMode.toggle()
        }, label: {
            Image(systemName: "gear")
                .imageScale(.large)
        })
        
    }
}


// Using SingleCardView struct to wraper whole contents of one card
struct SingleCardView: View{
    
    // Using '@EnvironmentObject' annotation to observe userData
    @EnvironmentObject var userData: ToDo
    var index: Int
    
    @State var showEditingPage = false
    
    var body: some View {
        // Using HStack to wraper all contents of card
        HStack{
            // The frame of card
            Rectangle()
                .frame(width: 6)
                .foregroundColor(.blue)
            
            Button(action: {
                self.userData.delete(id: index)
            }, label: {
                Image(systemName: "trash.circle")
                    .imageScale(.large)
                    .padding(.leading)
            })
            
            
            Button(action: {
                self.showEditingPage = true
            }, label: {
                Group {
                    // Using VStack to wraper mult-Text contents
                    VStack(alignment: .leading, spacing: 6.0) {
                        // Text obj
                        Text(self.userData.ToDoList[index].title)
                            .font(.headline)
                            .foregroundColor(.black)
                            .fontWeight(.heavy)
                        Text(self.userData.ToDoList[index].dueDate.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading)
                    
                    // Spacer() can be spaced certain space
                    Spacer()
                }
            })
            .sheet(isPresented: self.$showEditingPage, content: {
                EditingPage(title:self.userData.ToDoList[self.index].title,
                            dueDate:self.userData.ToDoList[self.index].dueDate,
                            id:self.index)
                    .environmentObject(self.userData)
            })
            
            
            
            
            
            
            
            // Image obj can display SF-Symbol image
            Image(systemName: self.userData.ToDoList[index].isChecked ? "checkmark.square.fill" : "square")
                .imageScale(.large)
                .padding(.trailing)
                .onTapGesture {
                    self.userData.check(id: self.index)
                }
        }
        .frame(height: 80)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10, x:0, y:10)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
