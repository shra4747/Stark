//
//  ChooseTVShowGenresView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import SwiftUI

struct ChooseTVShowGenresView: View {
    
    @State var clickedArr: [Int] = []
    @State var continueOnboarding = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Text("What Genres of TV Shows do you Like?")
                        .font(.custom("Avenir", size: 28))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center).padding()
                    
                    HStack {
                        GenreView(clickedArr: $clickedArr, genreID: 10759, genreName: "Action & Adventure")
                        GenreView(clickedArr: $clickedArr, genreID: 16, genreName: "Animation")
                    }
                    HStack {
                        GenreView(clickedArr: $clickedArr, genreID: 35, genreName: "Comedy")

                        GenreView(clickedArr: $clickedArr, genreID: 80, genreName: "Crime")
                        GenreView(clickedArr: $clickedArr, genreID: 99, genreName: "Documentary")
                    }
                    HStack {
                        GenreView(clickedArr: $clickedArr, genreID: 18, genreName: "Drama")
                        GenreView(clickedArr: $clickedArr, genreID: 10751, genreName: "Family")
                        GenreView(clickedArr: $clickedArr, genreID: 10762, genreName: "Kids")
                    }

                    HStack {
                        GenreView(clickedArr: $clickedArr, genreID: 9648, genreName: "Mystery")
                        GenreView(clickedArr: $clickedArr, genreID: 10763, genreName: "News")
                        GenreView(clickedArr: $clickedArr, genreID: 10764, genreName: "Reality")

                    }
                    HStack {
                        GenreView(clickedArr: $clickedArr, genreID: 10765, genreName: "Sci-Fi & Fantasy")
                        GenreView(clickedArr: $clickedArr, genreID: 10766, genreName: "Soap")
                        GenreView(clickedArr: $clickedArr, genreID: 10767, genreName: "Talk")
                    }
                    HStack {
                        GenreView(clickedArr: $clickedArr, genreID: 10768, genreName: "War & Politics")
                        GenreView(clickedArr: $clickedArr, genreID: 37, genreName: "Western")
                    }
                }
                
                Button(action: {
                    self.continueOnboarding.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                            .foregroundColor(.black)
                            .shadow(radius: 4)
                        Text("Choose Shows")
                            .font(.custom("Avenir", size: 22)).bold()
                            .foregroundColor(.white)
                    }
                }.padding()
                NavigationLink("", destination: ChooseTVShowsView(genres: clickedArr).navigationBarHidden(true), isActive: $continueOnboarding)
            }.navigationBarHidden(true)
        }
    }
}

struct ChooseTVShowGenresView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTVShowGenresView()
    }
}
