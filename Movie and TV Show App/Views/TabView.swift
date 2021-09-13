//
//  TempTabView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/8/21.
//

import SwiftUI

struct TabView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var tabType: TabType = .home
    @State var isShowingTabView = true
    @State var didResetEverything = false
    var body: some View {
        
        ZStack {
            NavigationLink("", destination: WelcomeView().navigationBarHidden(true), isActive: $didResetEverything)
            
            
            if isShowingTabView && didResetEverything == false {
                switch tabType {
                case .home :
                    HomeView(didResetEverything: $didResetEverything)
                case .search:
                    SearchView()
                case .saved:
                    BookmarkedView()
                }
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle().foregroundColor(colorScheme == .light ? .white : .black)
                            .cornerRadius(34, corners: [.topLeft, .topRight])
                            .frame(width: UIScreen.main.bounds.width, height: 88, alignment: .center)
                            .shadow(color: .gray, radius: 2, x: 0, y: -2)
                        HStack(spacing: 100) {
                            Button(action: {
                                self.tabType = .home
                            }) {
                                Image(systemName: "house").scaleEffect(1.8)
                                    .foregroundColor(tabType == .home ? colorScheme == .light ? .black : .white : Color(.lightGray))
                            }
                            Button(action: {
                                self.tabType = .search
                            }) {
                                Image(systemName: "magnifyingglass").scaleEffect(1.8)
                                    .foregroundColor(tabType == .search ? colorScheme == .light ? .black : .white : Color(.lightGray))
                            }
                            Button(action: {
                                self.tabType = .saved
                            }) {
                                Image(systemName: "bookmark").scaleEffect(1.8)
                                    .foregroundColor(tabType == .saved ? colorScheme == .light ? .black : .white : Color(.lightGray))
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
            .previewLayout(.device)
            .preferredColorScheme(.dark)
    }
}


enum TabType {
    case home, search, saved
}
