//
//  TempTabView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/8/21.
//

import SwiftUI

struct TabView: View {
    
    @State var tabType: TabType = .home
    @State var isShowingTabView = true
    var body: some View {
        
        ZStack {
            switch tabType {
            case .home :
                HomeView()
            case .search:
                SearchView(isShowingTabView: $isShowingTabView)
            case .saved:
                BookmarkedView()
            }
            
            if isShowingTabView {
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle().foregroundColor(.white)
                            .cornerRadius(34, corners: [.topLeft, .topRight])
                            .frame(width: UIScreen.main.bounds.width, height: 88, alignment: .center)
                            .shadow(color: .gray, radius: 5, x: 0, y: -2)
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
        }.onAppear {
            isShowingTabView = true
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
        TabView()
    }
}


enum TabType {
    case home, search, saved
}
