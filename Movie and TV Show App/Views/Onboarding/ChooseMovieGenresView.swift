//
//  ChooseMoviesView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import SwiftUI

struct ChooseMovieGenresView: View {
    
    @State var clickedArr: [Int] = []
    @State var continueOnboarding = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("What Genres of Movies do you Like?")
                    .font(.custom("Avenir", size: 28))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center).padding()
                
                HStack {
                    GenreView(clickedArr: $clickedArr, genreID: 28, genreName: "Action")
                    GenreView(clickedArr: $clickedArr, genreID: 12, genreName: "Adventure")
                    GenreView(clickedArr: $clickedArr, genreID: 16, genreName: "Animation")
                }
                HStack {
                    GenreView(clickedArr: $clickedArr, genreID: 35, genreName: "Comedy")
                    GenreView(clickedArr: $clickedArr, genreID: 80, genreName: "Crime")
                    GenreView(clickedArr: $clickedArr, genreID: 18, genreName: "Drama")
                }
                HStack {
                    GenreView(clickedArr: $clickedArr, genreID: 99, genreName: "Documentary")
                    GenreView(clickedArr: $clickedArr, genreID: 10751, genreName: "Family")
                }

                HStack {
                    GenreView(clickedArr: $clickedArr, genreID: 14, genreName: "Fantasy")
                    GenreView(clickedArr: $clickedArr, genreID: 36, genreName: "History")
                    GenreView(clickedArr: $clickedArr, genreID: 27, genreName: "Horror")

                }
                HStack {
                    GenreView(clickedArr: $clickedArr, genreID: 10402, genreName: "Music")
                    GenreView(clickedArr: $clickedArr, genreID: 9648, genreName: "Mystery")
                    GenreView(clickedArr: $clickedArr, genreID: 10749, genreName: "Romance")
                }
                HStack {
                    GenreView(clickedArr: $clickedArr, genreID: 878, genreName: "Science Fiction")
                    GenreView(clickedArr: $clickedArr, genreID: 10770, genreName: "TV Movie")
                }
                HStack {
                    GenreView(clickedArr: $clickedArr, genreID: 53, genreName: "Thriller")
                    GenreView(clickedArr: $clickedArr, genreID: 10752, genreName: "War")
                    GenreView(clickedArr: $clickedArr, genreID: 37, genreName: "Western")
                }
                
                Button(action: {
                    self.continueOnboarding.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                            .foregroundColor(.black)
                            .shadow(radius: 4)
                        Text("Choose Movies")
                            .font(.custom("Avenir", size: 22)).bold()
                            .foregroundColor(.white)
                    }
                }.padding()
                NavigationLink("", destination: ChooseMoviesView(genres: clickedArr).navigationBarHidden(true), isActive: $continueOnboarding)
            }.navigationBarHidden(true)
        }
    }
}

struct ChooseMoviesGenresView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseMovieGenresView()
    }
}

struct GenreView: View {
    
    @State var clicked = false
    @Binding var clickedArr: [Int]
    @State var genreID: Int
    @State var genreName: String
    
    var body: some View {
        Button(action: {
            clicked.toggle()
            if clicked {
                clickedArr.append(genreID)
            }
            else {
                if let index = clickedArr.firstIndex(of: genreID) {
                    clickedArr.remove(at: index)
                }
            }
        }) {
            ZStack {
                Text(genreName)
                    .foregroundColor(clicked ? .white : .black)
                    .padding(20)
                    .font(.custom("Avenir", size: 17))
                    .background(RoundedRectangle(cornerRadius: 20)
                        .frame(height: 50, alignment: .center)
                        .foregroundColor(.black)
                                    .opacity(clicked ? 0.8 : 0.16)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(.black), lineWidth: 1)))
            }
        }

    }
}
