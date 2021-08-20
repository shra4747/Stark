//
//  BookmarkedDetailView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/3/21.
//

import SwiftUI

struct BookmarkedDetailView: View {
    
    @State var group: BookmarkGroupModel
    @StateObject var viewModel = BookmarkedDetailViewModel()
    @Environment(\.presentationMode) var dismissPage
    @State var isPermissingToDelete = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(colorScheme == .light ? .init(hex: "EBEBEB") : .init(hex: "1A1A1A"))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 18) {
                    VStack {
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: group.gradient), startPoint: .topLeading, endPoint: .bottomTrailing).cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                                .opacity(0.6)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4.2)
                                .edgesIgnoringSafeArea(.all)
                                .shadow(color: colorScheme == .light ? Color(.sRGBLinear, white: 0, opacity: 0.33) : (.init(hex: "FFFFFF")), radius: 6)
                            VStack(spacing: 20) {
                                Text(group.icon)
                                    .font(.system(size: 50))
                                    .frame(height: 25)
                                    .foregroundColor(.black)
                                Text(group.name)
                                    .font(.custom("Avenir", size: 27))
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .light ? .black : .white)

                            }.offset(y: 15)
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .top, spacing: 45) {
                            ForEach(viewModel.bookmarkedContent.sorted().uniqued(), id: \.self) { mediaContent in
                                if mediaContent.media_type == .movie {
                                    ZStack(alignment: .topTrailing) {
                                        NavigationLink(
                                            destination: MovieDetailView(id: mediaContent.id, isGivingData: false, givingMovie: SearchModel.EmptyModel.Movie).navigationBarHidden(true),
                                            label: {
                                                VStack(alignment: .leading) {
                                                    Image(uiImage: mediaContent.poster_path.loadImage(type: .similar, colorScheme: (colorScheme == .light ? .light : .dark)))
                                                        .scaleEffect(0.5)
                                                        .frame(width: 220, height: 350)
                                                        .cornerRadius(18)
                                                        .shadow(color: Color(hex: "000000"), radius: 5, x: 0, y: 3)
                                                    Text(mediaContent.title)
                                                        .font(.custom("Avenir", size: 20))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                                        .frame(width: 210, alignment: .leading)
                                                    if group.id == "002" {
                                                        Text("\(CountdownDate().returnDaysUntil(dateString: mediaContent.release_date)) days")
                                                            .font(.custom("Avenir", size: 25))
                                                            .foregroundColor(colorScheme == .light ? Color(.darkGray) : Color(.lightGray))
                                                    }

                                                }
                                            })
                                        if group.id == "002" {
                                            Button(action: {
                                                if let index = viewModel.bookmarkedContent.firstIndex(of: mediaContent) {
                                                    viewModel.bookmarkedContent.remove(at: index)
                                                    
                                                    let encoded = try? JSONEncoder().encode(viewModel.bookmarkedContent)
                                                    UserDefaults.standard.set(encoded, forKey: "saved-\(group.id)")
                                                    UserDefaults(suiteName: "group.com.shravanprasanth.movietvwidgetgroup")!.set(encoded, forKey: "countdownsData")

                                                }
                                            }) {
                                                ZStack {
                                                    Circle()
                                                        .frame(width: 40, height: 40)
                                                        .foregroundColor(colorScheme == .light ? .white : .black)
                                                        .shadow(color: colorScheme == .light ? Color(.sRGBLinear, white: 0, opacity: 0.33) : (.init(hex: "484848")), radius: 10)
                                                    Image(systemName: "trash")
                                                        .foregroundColor(colorScheme == .light ? Color(.systemGray) : Color(.lightGray))
                                                }
                                            }.offset(x: 20, y: 340)
                                        }
                                        else {
                                            Button(action: {
                                                if let index = viewModel.bookmarkedContent.firstIndex(of: mediaContent) {
                                                    viewModel.bookmarkedContent.remove(at: index)
                                                    
                                                    let encoded = try? JSONEncoder().encode(viewModel.bookmarkedContent)
                                                    UserDefaults.standard.set(encoded, forKey: "saved-\(group.id)")
                                                }
                                            }) {
                                                ZStack {
                                                    Circle()
                                                        .frame(width: 40, height: 40)
                                                        .foregroundColor(colorScheme == .light ? .white : .black)
                                                        .shadow(color: colorScheme == .light ? Color(.sRGBLinear, white: 0, opacity: 0.33) : (.init(hex: "484848")), radius: 10)
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(colorScheme == .light ? Color(.systemGray) : Color(.lightGray))
                                                }
                                            }.offset(x: 20, y: 340)
                                        }
                                    }
                                }
                                else {
                                    ZStack(alignment: .topTrailing) {
                                        NavigationLink(
                                            destination: TVShowDetailView(id: mediaContent.id, isGivingData: false, givingShow: SearchModel.EmptyModel.TVShow).navigationBarHidden(true),
                                            label: {
                                                VStack(alignment: .leading) {
                                                    Image(uiImage: mediaContent.poster_path.loadImage(type: .similar, colorScheme: (colorScheme == .light ? .light : .dark)))
                                                        .scaleEffect(0.5)
                                                        .frame(width: 220, height: 350)
                                                        .cornerRadius(18)
                                                        .shadow(color: Color(hex: "000000"), radius: 5, x: 0, y: 3)
                                                    Text(mediaContent.title)
                                                        .font(.custom("Avenir", size: 22))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                                        .frame(width: 210, alignment: .leading)
                                                }
                                            })
                                        
                                        Button(action: {
                                            if let index = viewModel.bookmarkedContent.firstIndex(of: mediaContent) {
                                                viewModel.bookmarkedContent.remove(at: index)
                                                
                                                let encoded = try? JSONEncoder().encode(viewModel.bookmarkedContent)
                                                UserDefaults.standard.set(encoded, forKey: "saved-\(group.id)")
                                            }
                                        }) {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 40, height: 40)
                                                    .foregroundColor(colorScheme == .light ? .white : .black)
                                                    .shadow(color: colorScheme == .light ? Color(.sRGBLinear, white: 0, opacity: 0.33) : (.init(hex: "484848")), radius: 10)
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(colorScheme == .light ? Color(.systemGray) : Color(.lightGray))
                                            }
                                        }.offset(x: 20, y: 340)
                                    }
                                }
                            }
                        }.padding().padding(.trailing, 20)
                    }
                    Spacer()
                }.onAppear {
                    DispatchQueue.main.async {
                        viewModel.groupID = group.id
                        viewModel.load()
                    }
            }.navigationBarHidden(true)
                
                Button(action: {
                    dismissPage.wrappedValue.dismiss()
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .shadow(radius: 10)
                        Image(systemName: "arrow.left")
                            .foregroundColor(colorScheme == .light ? Color(.systemGray) : Color(.lightGray))
                    }
                }.offset(x: -(UIScreen.main.bounds.width/2 - 45), y: -(UIScreen.main.bounds.height/2 - 60))
                
                Button(action: {
                    self.isPermissingToDelete.toggle()
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .shadow(radius: 10)
                        Image(systemName: "trash")
                            .foregroundColor(colorScheme == .light ? Color(.systemGray) : Color(.lightGray))
                    }
                }.offset(x: (UIScreen.main.bounds.width/2 - 45), y: -(UIScreen.main.bounds.height/2 - 60))
                .alert(isPresented: $isPermissingToDelete, content: {
                    Alert(title: Text("Are You Sure?"), message: Text("All of the content and your '\(group.name)' group will be deleted."), primaryButton: .default(Text("Confirm"), action: {
                        viewModel.deleteGroup(group: group)
                        dismissPage.wrappedValue.dismiss()
                    }), secondaryButton: .default(Text("Go Back!"), action: {
                        dismissPage.wrappedValue.dismiss()
                    }))
                })
            }
        }
    }
}

struct BookmarkedDetailView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        BookmarkedDetailView(group: BookmarkModelDefaultGroups.countdown)
    }
}
