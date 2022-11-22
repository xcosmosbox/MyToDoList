//
//  ContentView.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 20/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State var isChecked: Bool = false
    
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
//        VStack {
//            Text("Do Homework")
//            Text("TODO")
//        }
        HStack{
            Rectangle()
                .frame(width: 6)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 6.0) {
                Text("Do Homework")
                    .font(.headline)
                    .fontWeight(.heavy)
                Text("2022.11.01")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
            
            Spacer()
            
            Image(systemName: self.isChecked ? "checkmark.square.fill" : "square")
                .imageScale(.large)
                .padding(.trailing)
                .onTapGesture {
                    self.isChecked.toggle()
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
