//
//  WelcomeView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var name = ""
    @State var continueOnboarding = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!")
                    .font(.custom("Avenir", size: 43))
                    .fontWeight(.heavy)
                Image("home_cinema")
                    .resizable()
                    .scaleEffect(1.1)
                    .frame(width: 150, height: 150, alignment: .center)
                
                TextField("What's Your Name?", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.custom("Avenir", size: 20))
                    .padding()
                    .shadow(radius: 20).disableAutocorrection(true)
                Button(action: {
                    if name != "" {
                        UserDefaults.standard.set(name, forKey: "__NAME__")
                        self.continueOnboarding.toggle()
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                            .foregroundColor(.black)
                            .shadow(radius: 4)
                        Text("Get Started!")
                            .font(.custom("Avenir", size: 22)).bold()
                            .foregroundColor(.white)
                    }
                }
                NavigationLink("", destination: ChooseAvatarView().navigationBarHidden(true), isActive: $continueOnboarding)
            }.navigationBarHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

