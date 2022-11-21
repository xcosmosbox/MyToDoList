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
        VStack(alignment: .leading, spacing: 6.0) {
            Text("Do Homework")
            Text("2022.11.01")
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
