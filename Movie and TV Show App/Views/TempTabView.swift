//
//  TempTabView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/8/21.
//

import SwiftUI

struct TempTabView: View {
    var body: some View {
        TabView {
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            BookmarkedView().tabItem {
                Label("Saved", systemImage: "bookmark")
            }
        }
    }
}

struct TempTabView_Previews: PreviewProvider {
    static var previews: some View {
        TempTabView()
    }
}
