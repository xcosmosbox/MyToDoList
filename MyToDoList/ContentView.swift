//
//  ContentView.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 20/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View{
        SingleCardView()
    }

}


// Using SingleCardView struct to wraper whole contents of one card
struct SingleCardView: View{
    // @State wrapper can control asynchronously 'isChecked' variable
    @State var isChecked: Bool = false
    
    var body: some View {
        // Using HStack to wraper all contents of card
        HStack{
            // The frame of card
            Rectangle()
                .frame(width: 6)
                .foregroundColor(.blue)
            
            // Using VStack to wraper mult-Text contents
            VStack(alignment: .leading, spacing: 6.0) {
                // Text obj
                Text("Do Homework")
                    .font(.headline)
                    .fontWeight(.heavy)
                Text("2022.11.01")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
            
            // Spacer() can be spaced certain space
            Spacer()
            
            // Image obj can display SF-Symbol image
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
