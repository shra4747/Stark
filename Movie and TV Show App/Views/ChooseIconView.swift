//
//  ChooseIconView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/7/21.
//

import SwiftUI

struct ChooseIconView: View {
    
    @Binding var icon: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(icon != "" ? icon : "?")
                .font(.system(size: 100))
            
            EmojiTextField(text: $icon, placeholder: "Enter Emoji Here: ")
                .font(.custom("Avenir", size: 20))
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 70, height: 50, alignment: .center)
                .offset(x: 75)
            Spacer()
        }.padding(.top, 50)
    }
}
