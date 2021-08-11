//
//  TempTabView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/8/21.
//

import SwiftUI

struct TempTabView: View {
    
    @State var tabType: TabType = .search
    
    var body: some View {
        
        ZStack {
            switch tabType {
            case .home :
                Text("Home")
            case .search:
                SearchView()
            case .saved:
                BookmarkedView()
            }
            
            VStack {
                Spacer()
                ZStack {
                    Rectangle().foregroundColor(.white)
                        .cornerRadius(34, corners: [.topLeft, .topRight])
                        .frame(width: UIScreen.main.bounds.width, height: 88, alignment: .center)
                        .shadow(color: .gray, radius: 5, x: 0, y: -3)
                    HStack(spacing: 100) {
                        Button(action: {
                            self.tabType = .home
                        }) {
                            Image(systemName: "house").scaleEffect(1.8)
                                .foregroundColor(tabType == .home ? .black : Color(.lightGray))
                                .shadow(radius: 1)
                        }
                        Button(action: {
                            self.tabType = .search
                        }) {
                            Image(systemName: "magnifyingglass").scaleEffect(1.8)
                                .foregroundColor(tabType == .search ? .black : Color(.lightGray))
                                .shadow(radius: 1)
                        }
                        Button(action: {
                            self.tabType = .saved
                        }) {
                            Image(systemName: "bookmark").scaleEffect(1.8)
                                .foregroundColor(tabType == .saved ? .black : Color(.lightGray))
                                .shadow(radius: 1)
                        }
                        
                    }
                }
                
                
                    
            }.edgesIgnoringSafeArea(.all)
        }
        
//        TabView {
//            SearchView().tabItem {
//                Label("Search", systemImage: "magnifyingglass")
//            }
//            BookmarkedView().tabItem {
//                Label("Saved", systemImage: "bookmark")
//            }
//        }
    }
}




struct TempTabView_Previews: PreviewProvider {
    static var previews: some View {
        TempTabView()
    }
}


enum TabType {
    case home, search, saved
}
