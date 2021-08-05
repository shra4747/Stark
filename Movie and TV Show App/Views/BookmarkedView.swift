//
//  BookmarkedView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/1/21.
//

import SwiftUI

struct BookmarkedView: View {
    
    @StateObject var viewModel = BookmarkedViewModel()
    
    var body: some View {
        List(viewModel.groups, id: \.self) { group in
//            NavigationLink(
//                destination: BookmarkedDetailView(),
//                label: {
//                    Text(group.name)
//                })
        }.onAppear {
            viewModel.load()
        }
    }
}

struct BookmarkedView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedView()
    }
}
