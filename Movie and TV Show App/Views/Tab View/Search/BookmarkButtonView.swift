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
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = BookmarkButtonViewModel()
    
    var body: some View {
        Button(action: {
            viewModel.buttonClick()
        }) {
            ZStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .shadow(color: colorScheme == .light ? Color(.sRGBLinear, white: 0, opacity: 0.33) : (.init(hex: "484848")), radius: 10)
                Image(systemName: viewModel.hasBeenSaved ? "bookmark.fill" : "bookmark")
                    .scaleEffect(1.63)
                    .foregroundColor(colorScheme == .light ? Color(.systemGray) : Color(.lightGray))
            }
        }.onAppear {
            viewModel.id = id
            viewModel.poster_path = poster_path
            viewModel.title = title
            viewModel.media_type = media_Type
            viewModel.release_Date = release_date
            viewModel.changeStateOnAppear()
        }.sheet(isPresented: $viewModel.showChooseGroupView) {             ChooseGroupView(model: BookmarkModel(id: id, poster_path: poster_path, title: title, media_type: media_Type, release_date: release_date))
        }
    }
}
