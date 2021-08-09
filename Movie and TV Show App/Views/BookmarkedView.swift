//
//  BookmarkedView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/1/21.
//

import SwiftUI

struct BookmarkedView: View {
    
    @StateObject var viewModel = BookmarkedViewModel()
    @State var isPresentingAddNewGroup = false
    let watchLater = BookmarkModelDefaultGroups.watchLater
    let countdown = BookmarkModelDefaultGroups.countdown
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(.init(hex: "EBEBEB"))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 25) {
                    NavigationLink(
                        destination: BookmarkedDetailView(group: BookmarkModelDefaultGroups.countdown),
                        label: {
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: countdown.gradient), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .cornerRadius(18)
                                    .opacity(0.6)
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 100)
                                    .shadow(color: Color(.darkGray), radius: 6)
                                VStack(spacing: 10) {
                                    Text(countdown.icon)
                                        .font(.system(size: 45))
                                        .frame(height: 28)
                                        .foregroundColor(.black)
                                    Text(countdown.name)
                                        .font(.custom("Avenir", size: 23))
                                        .fontWeight(.semibold)

                                }.foregroundColor(.black).offset(y: 5)
                            }
                        })
                    
                    NavigationLink(
                        destination: BookmarkedDetailView(group: BookmarkModelDefaultGroups.watchLater),
                        label: {
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: watchLater.gradient), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .cornerRadius(18)
                                    .opacity(0.6)
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 160)
                                    .shadow(color: Color(.darkGray), radius: 6)
                                VStack(spacing: 20) {
                                    Text(watchLater.icon)
                                        .font(.system(size: 53))
                                        .frame(height: 28)
                                        .foregroundColor(.black)
                                    Text(watchLater.name)
                                        .font(.custom("Avenir", size: 27))
                                        .fontWeight(.semibold)

                                }.foregroundColor(.black).offset(y: 10)
                            }
                        })
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 30) {
                            VStack(spacing: 22) {
                                ForEach(viewModel.groups.chunked(into: 2), id: \.self) { chunk in
                                    HStack(spacing: 20) {
                                        ForEach(chunk, id: \.self) { group in
                                            NavigationLink(
                                                destination: BookmarkedDetailView(group: group),
                                                label: {
                                                    ZStack {
                                                        LinearGradient(gradient: Gradient(colors: group.gradient), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                            .cornerRadius(18)
                                                            .opacity(0.6)
                                                            .frame(width: UIScreen.main.bounds.width/2 - 50, height: UIScreen.main.bounds.width/2 - 50)
                                                            .shadow(color: Color(.darkGray), radius: 6)
                                                        VStack(spacing: 20) {
                                                            Text(group.icon)
                                                                .font(.system(size: 54))
                                                                .frame(height: 30)
                                                                .foregroundColor(.black)
                                                            Text(group.name)
                                                                .font(.custom("Avenir", size: 22))
                                                                .foregroundColor(.black)
                                                                .fontWeight(.medium)
                                                        }.offset(y: 5)
                                                    }
                                                })
                                        }
                                    }
                                }
                            }
                            
                            Button(action: {
                                self.isPresentingAddNewGroup.toggle()
                            }) {
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color(.white)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .cornerRadius(18)
                                        .opacity(0.6)
                                        .frame(width: UIScreen.main.bounds.width - 60, height: 60)
                                        .shadow(color: Color(.darkGray), radius: 6)
                                    HStack(spacing: 15) {
                                        Text("Add New Group")
                                            .font(.custom("Avenir", size: 16))
                                            .fontWeight(.medium)
                                        Image(systemName: "plus")
                                            
                                        

                                    }.offset(y: 0)
                                }.foregroundColor(.black)
                            }.sheet(isPresented: $isPresentingAddNewGroup, onDismiss: {
                                viewModel.load()
                            }, content: {
                                AddNewGroupView()
                            })
                        }.frame(width: UIScreen.main.bounds.width).padding(.top)
                    }
                    
                    Spacer()
                }.padding(.top, 50)
            }.navigationBarHidden(true).onAppear {
                viewModel.load()
            }
        }
    }
}

struct BookmarkedView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedView()
    }
}
