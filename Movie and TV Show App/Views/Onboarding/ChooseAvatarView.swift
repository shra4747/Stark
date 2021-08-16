//
//  ChooseAvatarView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import SwiftUI

struct ChooseAvatarView: View {
    
    @State var continueOnboarding = false
    @State var pickingAvatar = false
    @State var avatar = UIImage(named: "ironman")
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose a Profile Picture!")
                    .font(.custom("Avenir", size: 33))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center).padding()
                
                Text("Tap to Choose from your Photo Library")
                    .font(.custom("Avenir", size: 20)).offset(y: -10)

                Button(action: {
                    self.pickingAvatar.toggle()
                }) {
                    Image(uiImage: avatar!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200, alignment: .center)
                        .cornerRadius(500).shadow(radius: 10).padding(.bottom, 30)
                    
                }.sheet(isPresented: $pickingAvatar) {
                    ImagePickerView(sourceType: .photoLibrary) { image in
                        self.avatar = image
                    }
                }
                
                Button(action: {
                    if avatar != UIImage(named: "ironman") {
                        setImage(image: avatar!, key: "__AVATAR__")
                        self.continueOnboarding.toggle()
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                            .foregroundColor(.black)
                            .shadow(radius: 4)
                        Text("Next")
                            .font(.custom("Avenir", size: 22)).bold()
                            .foregroundColor(.white)
                    }
                }
                NavigationLink("", destination: ChooseMovieGenresView().navigationBarHidden(true), isActive: $continueOnboarding)
            }.navigationBarHidden(true).offset(y: -30)
        }
    }
}

struct ChooseAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseAvatarView()
    }
}
