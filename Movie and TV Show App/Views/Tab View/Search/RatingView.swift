//
//  RatingView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/14/21.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var starImg: Bool
    @State var selectedStar = 0
    @State var previousStar = 0
    @Environment(\.presentationMode) var dismissPage
    @State var id: Int
    @State var mediaType: SearchModel.MediaType
    
    var body: some View {
        VStack {
            
            Text("\(selectedStar) stars")
                .font(.custom("Avenir", size: 26))
                .bold()
            
            HStack {
                Button(action: {
                    selectedStar = 1
                }) {
                    Image(systemName: selectedStar > 0 && selectedStar < 6 ? "star.fill" : "star")
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: 35, height: 35)
                }.animation(.easeInOut)
                Button(action: {
                    selectedStar = 2
                }) {
                    Image(systemName: selectedStar > 1 && selectedStar < 6 ? "star.fill" : "star")
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: 35, height: 35)
                }.animation(.easeInOut)
                Button(action: {
                    selectedStar = 3
                }) {
                    Image(systemName: selectedStar > 2 && selectedStar < 6 ? "star.fill" : "star")
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: 35, height: 35)
                }.animation(.easeInOut)
                Button(action: {
                    selectedStar = 4
                }) {
                    Image(systemName: selectedStar > 3 && selectedStar < 6 ? "star.fill" : "star")
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: 35, height: 35)
                }.animation(.easeInOut)
                Button(action: {
                    selectedStar = 5
                }) {
                    Image(systemName: selectedStar > 4 && selectedStar < 6 ? "star.fill" : "star")
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: 35, height: 35)
                }.animation(.easeInOut)
            }
            
            Button(action: {
                RecommendationEngine().removeFromAllWR(mediaType: mediaType, model: WRatedModel(id: id, stars_rated: previousStar))
                RecommendationEngine().WatchAndRated(mediaType: mediaType, model: WRatedModel(id: id, stars_rated: selectedStar))
                starImg = true
                dismissPage.wrappedValue.dismiss()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: UIScreen.main.bounds.width - 100, height: 55, alignment: .center)
                        .shadow(radius: 5)
                        .foregroundColor(.yellow)
                        .opacity(0.7)
                    Label("Rate", systemImage: "star.fill")
                        .font(.custom("Avenir", size: 21))
                        .foregroundColor(.black)
                }.offset(y: 20)
            }
            
            Spacer()
        }.padding(.top).onAppear {
            let rc = RecommendationEngine().loadRatingViewState(mediaType: mediaType, id: id)
            if rc.wr {
                self.selectedStar = rc.stars
                self.previousStar = rc.stars
            }
        }
    }
}
