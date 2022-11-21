//
//  ContentView.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 20/11/2022.
//

import SwiftUI

struct ContentView: View {
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
            
            Spacer()
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
