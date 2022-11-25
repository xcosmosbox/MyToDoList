//
//  ContentView.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 20/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    // Using '@ObservedObject' annotation to asynchronouse value of 'isChecked' variable
    @ObservedObject var userData: ToDo = ToDo(data: [SingleToDo(title:"do homework", dueDate:Date()),                                                   SingleToDo(title:"Dinner", dueDate:Date()),
                                                     SingleToDo(title:"play video game", dueDate:Date()),
                                                     SingleToDo(title:"Sleep", dueDate:Date()),
                                                     SingleToDo(title:"wake up", dueDate:Date()),
                                                     SingleToDo(title:"do tutorial", dueDate:Date()),
                                                     SingleToDo(title:"Sleep", dueDate:Date())])
    
    @State var showEditingPage = false
    
    
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
                            SingleCardView(index:item.id)
                                .environmentObject(self.userData)
                                .padding(.top)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Reminder")
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


// Using SingleCardView struct to wraper whole contents of one card
struct SingleCardView: View{
    
    // Using '@EnvironmentObject' annotation to observe userData
    @EnvironmentObject var userData: ToDo
    var index: Int
    
    var body: some View {
        // Using HStack to wraper all contents of card
        HStack{
            // The frame of card
            Rectangle()
                .frame(width: 6)
                .foregroundColor(.blue)
            
            // Using VStack to wraper mult-Text contents
            Group {
                VStack(alignment: .leading, spacing: 6.0) {
                    // Text obj
                    Text(self.userData.ToDoList[index].title)
                        .font(.headline)
                        .fontWeight(.heavy)
                    Text(self.userData.ToDoList[index].dueDate.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading)
                
                // Spacer() can be spaced certain space
                Spacer()
            }
            
            
            
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
