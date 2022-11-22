//
//  ContentView.swift
//  MyToDoList
//
//  Created by Yuxiang Feng on 20/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View{
        /** Using ScrollView to implement scroll effect
                @param .vertical : vertical effect
                @param showsIndicators: show indicator -> Bool
         */
        //
        ScrollView(.vertical, showsIndicators: true){
            VStack{
                ForEach(0..<15){
                    item in
                    SingleCardView(String(item))
                        .padding()
                }
            }
            .padding(.horizontal)
        }
        
        
    }

}


// Using SingleCardView struct to wraper whole contents of one card
struct SingleCardView: View{
    
    // constructor
    init(_ title:String) {
        self.title = title
    }
    
    // @State wrapper can control asynchronously 'isChecked' variable
    @State var isChecked: Bool = false
    
    var title: String = ""
    var dueDate: Date = Date()
    
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
                Text(self.title)
                    .font(.headline)
                    .fontWeight(.heavy)
                Text(self.dueDate.description)
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
