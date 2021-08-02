//
//  BookmarkButtonView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/1/21.
//

import SwiftUI

struct BookmarkButtonView: View {
    
    @State var id: Int
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
            viewModel.changeStateOnAppear()
        }
    }
}
