//
//  BookmarkButtonView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/1/21.
//

import SwiftUI

struct BookmarkButtonView: View {
    
    @State var id: Int
    @State var poster_path: String
    @State var title: String
    @State var media_Type: SearchModel.MediaType
    @State var release_date: String
    
    @StateObject var viewModel = BookmarkButtonViewModel()
    
    var body: some View {
        Button(action: {
            viewModel.buttonClick()
        }) {
            ZStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                Image(systemName: viewModel.hasBeenSaved ? "bookmark.fill" : "bookmark")
                    .scaleEffect(1.63)
                    .foregroundColor(Color(.darkGray))
            }
        }.onAppear {
            viewModel.id = id
            viewModel.poster_path = poster_path
            viewModel.title = title
            viewModel.media_type = media_Type
            viewModel.release_Date = release_date
            viewModel.changeStateOnAppear()
        }
    }
}
