//
//  RatingButtonView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/14/21.
//

import SwiftUI

struct RatingButtonView: View {
    
    @State var didTapButton = false
    @State var id: Int
    @State var mediaType: SearchModel.MediaType
    @State var isWR = false
    
    var body: some View {
        Button(action: {
            self.didTapButton.toggle()
        }) {
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                Image(systemName: isWR ? "star.fill" : "star")
                    .foregroundColor(Color(.systemGray))
            }
        }.sheet(isPresented: $didTapButton, content: {
            RatingView(starImg: $isWR, id: id, mediaType: mediaType)
        }).onAppear {
            let rc = RecommendationEngine().loadRatingViewState(mediaType: mediaType, id: id)
            if rc.wr {
                self.isWR = true
            }
        }
    }
}


