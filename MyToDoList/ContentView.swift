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
                output.append(SingleToDo(title: item.title, dueDate: item.dueDate, isChecked: item.isChecked, isFavorite: item.isFavorite, id: output.count))
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
    @State var showLikeOnly = false
    
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
                                if (!self.showLikeOnly || item.isFavorite){
                                    SingleCardView(index:item.id, editingMode: self.$editingMode, selection: self.$selection)
                                        .environmentObject(self.userData)
                                        .padding(.top)
                                        .padding(.horizontal)
                                        .animation(.spring(), value: self.editingMode)
                                        .transition(.slide)
                                }
                               
                            }
                            
                        }
                        
                    }
                }
                .navigationTitle("Reminder")
                .toolbar(content: {
                    HStack(spacing: 20) {
                        if (self.editingMode){
                            DeleteButton(selection: self.$selection)
                                .environmentObject(self.userData)
                        }
                        if (!self.editingMode){
                            ShowLikeButton(showLikeOnly: self.$showLikeOnly)
                        }
                        EditingButton(editingMode: self.$editingMode, selection: self.$selection)
                    }
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

struct ShowLikeButton: View{
    @Binding var showLikeOnly: Bool
    var body: some View{
        Button(action: {
            self.showLikeOnly.toggle()
        }, label: {
            Image(systemName: self.showLikeOnly ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundColor(.yellow)
        })
        
    }
}


struct EditingButton:View {
    @Binding var editingMode: Bool
    @Binding var selection: [Int]
    var body: some View{
        Button(action: {
            self.editingMode.toggle()
            self.selection.removeAll()
        }, label: {
            Image(systemName: "gear")
                .imageScale(.large)
        })
        
    }
}

struct DeleteButton: View {
    @Binding var selection: [Int]
    @EnvironmentObject var userData : ToDo
    var body: some View{
        Button(action: {
            for item in self.selection{
                self.userData.delete(id: item)
            }
        }, label: {
            Image(systemName: "trash")
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
    @Binding var editingMode: Bool
    @Binding var selection: [Int]
    
    var body: some View {
        // Using HStack to wraper all contents of card
        HStack{
            // The frame of card
            Rectangle()
                .frame(width: 6)
                .foregroundColor(.blue)
            
            if (self.editingMode){
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)){
                        self.userData.delete(id: index)
                    }
                    
                }, label: {
                    Image(systemName: "trash.circle")
                        .imageScale(.large)
                        .padding(.leading)
                })
            }
            
            
            Button(action: {
                if(!self.editingMode){
                    self.showEditingPage = true
                }
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
                            isFavorite:self.userData.ToDoList[self.index].isFavorite,
                            id:self.index)
                    .environmentObject(self.userData)
            })
            
            
            if(self.userData.ToDoList[index].isFavorite){
                Image(systemName: "star.fill")
                    .imageScale(.large)
                    .foregroundColor(.yellow)
            }
            
            
            if(!self.editingMode){
                // Image obj can display SF-Symbol image
                Image(systemName: self.userData.ToDoList[index].isChecked ? "checkmark.square.fill" : "square")
                    .imageScale(.large)
                    .padding(.trailing)
                    .onTapGesture {
                        self.userData.check(id: self.index)
                    }
            }
            else{
                Image(systemName: self.selection.firstIndex(where: {
                    $0 == self.index
                }) != nil ? "checkmark.circle.fill" : "circle")
                    .imageScale(.large)
                    .padding(.trailing)
                    .onTapGesture {
                        if self.selection.firstIndex(where: {
                            $0 == self.index
                        }) == nil {
                            self.selection.append(self.index)
                        }
                        else{
                            self.selection.remove(at:
                                self.selection.firstIndex(where: {
                                $0 == self.index
                            })!)
                        }
                    }
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
//        ContentView()
        ContentView(userData: ToDo(data: [SingleToDo(title: "homework",dueDate: Date(),isFavorite: false)]))
    }
}
