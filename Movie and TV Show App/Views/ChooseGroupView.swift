//
//  ChooseGroupView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/8/21.
//

import SwiftUI

struct ChooseGroupView: View {
    
    @StateObject var viewModel = ChooseGroupViewModel()
    @State var model: BookmarkModel
    let watchLater = BookmarkModelDefaultGroups.watchLater
    let countdown = BookmarkModelDefaultGroups.countdown
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.init(hex: "EBEBEB"))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all).padding(.top, 20)
            VStack(spacing: 25) {
                Button(action: {
                    viewModel.addMediaToGroup(for: countdown.id)
                    presentationMode.wrappedValue.dismiss()
                }) {
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
                }.offset(y: -30)
                
                Button(action: {
                    viewModel.addMediaToGroup(for: watchLater.id)
                    presentationMode.wrappedValue.dismiss()
                }) {
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
                }.offset(y: -30)
                
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 30) {
                            VStack(spacing: 22) {
                                ForEach(viewModel.groups.chunked(into: 2), id: \.self) { chunk in
                                    HStack(spacing: 20) {
                                        ForEach(chunk, id: \.self) { group in
                                            Button(action: {
                                                viewModel.addMediaToGroup(for: group.id)
                                                presentationMode.wrappedValue.dismiss()
                                            }) {
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
                                            }
                                        }
                                    }
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width).padding(.top)
                    }
                
                Spacer()
            }
        }.onAppear {
            viewModel.model = model
            viewModel.load()
        }
    }
}

