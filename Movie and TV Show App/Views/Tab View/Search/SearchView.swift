//
//  ContentView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/28/21.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var scrollViewID = UUID()

    var body: some View {
        NavigationView {
            GeometryReader { _ in
                ZStack {
                    Rectangle()
                        .foregroundColor(colorScheme == .light ? .init(hex: "EBEBEB") : .init(hex: "1A1A1A"))
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        VStack(spacing: -20) {
                            HStack(spacing: 13) {
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(colorScheme == .light ? (.darkGray) : .gray), lineWidth: 1))
                                        .frame(width: UIScreen.main.bounds.width - 70, height: 50)
                                        .foregroundColor(colorScheme == .light ? .white : .black)
                                    TextField("", text: $viewModel.query)
                                        .introspectTextField { uiTextField in
                                            uiTextField.attributedPlaceholder = NSAttributedString(string: "Search for anything...",
                                                                                                   attributes: [NSAttributedString.Key.foregroundColor: (colorScheme == .light ? UIColor.darkGray : UIColor.lightGray)])
                                        }
                                        .foregroundColor(Color.white)
                                        .padding(5)
                                        .disableAutocorrection(true)
                                        .frame(width: UIScreen.main.bounds.width - 120, alignment: .leading)
                                        .padding(.leading, 10)
                                        .font(.custom("Avenir", size: 17))
                                        
                                        
                                }
                                Button(action: {
                                    DispatchQueue.main.async {
                                        scrollViewID = UUID()
                                        viewModel.search()
                                    }
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }) {
                                    Image(systemName: "magnifyingglass")
                                        .scaleEffect(1.65)
                                        .foregroundColor(colorScheme == .light ? .black : Color(.lightGray))
                                        
                                }
                            }.padding()
                            Picker("", selection: $viewModel.selectedType) {
                                ForEach(SearchModel.MediaType.allCases) { mediaType in
                                    if mediaType == .show {
                                        Text("TV \(mediaType.displayName)s")
                                            .font(.custom("Avenir", size: 14))
                                            .tag(mediaType)
                                    }
                                    else {
                                        Text("\(mediaType.displayName)s")
                                            .font(.custom("Avenir", size: 14))
                                            .tag(mediaType)
                                    }
                                }
                            }.pickerStyle(SegmentedPickerStyle()).padding()
                        }.navigationBarHidden(true)
                        
                        if viewModel.selectedType == .movie {
                            if viewModel.movies.count != 0 {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 30) {
                                        ForEach(viewModel.movies, id: \.self) { movie in
                                            NavigationLink(
                                                destination: MovieDetailView(id: movie.id, isGivingData: true, givingMovie: movie).navigationBarHidden(true),
                                                label: {
                                                    VStack(alignment: .leading) {
                                                        Image(uiImage: movie.poster_path?.loadImage() ?? SearchModel.EmptyModel.Image)
                                                            .scaleEffect(0.65)
                                                            .frame(width: 296, height: 440)
                                                            .cornerRadius(18)
                                                            .shadow(color: Color(hex: colorScheme == .light ? "000000" : "6E6E6E"), radius: 5, x: 0, y: 3)
                                                        HStack {
                                                            Text(movie.title)
                                                                .font(.custom("Avenir", size: 22))
                                                                .fontWeight(.bold)
                                                                .foregroundColor(colorScheme == .light ? Color(.black) : .init(hex: "F2F2F2"))
                                                                .frame(width: 290, alignment: .leading)
                                                            Spacer()
                                                        }
                                                        
                                                        HStack {
                                                            Text(viewModel.returnGenresText(for: movie.genres))
                                                                .font(.custom("Avenir", size: 16))
                                                                .fontWeight(.medium)
                                                                .foregroundColor(Color(hex: colorScheme == .light ? "777777" : "D0D0D0"))
                                                                .frame(width: 290, alignment: .leading)
                                                            Spacer()
                                                        }
                                                    }
                                                })
                                        }
                                    }.padding()
                                }.id(self.scrollViewID)

                            }
                            else {
                                VStack {
                                    Image(systemName: "tv")
                                        .resizable()
                                        .frame(width: 90, height: 70)
                                        .foregroundColor(colorScheme == .light ? Color(.darkGray) : Color(.lightGray))
                                    Text("Search for TV Shows \nor Movies!").multilineTextAlignment(.center)
                                        .font(.custom("Avenir", size: 22))
                                }.offset(y: UIScreen.main.bounds.height/2 - 235)
                            }
                        }
                        else {
                            if viewModel.shows.count != 0 {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 30) {
                                        ForEach(viewModel.shows, id: \.self) { show in
                                            NavigationLink(
                                                destination: TVShowDetailView(id: show.id, isGivingData: true, givingShow: show).navigationBarHidden(true),
                                                label: {
                                                    VStack(alignment: .leading) {
                                                        Image(uiImage: show.poster_path?.loadImage() ?? SearchModel.EmptyModel.Image)
                                                            .scaleEffect(0.65)
                                                            .frame(width: 296, height: 440)
                                                            .cornerRadius(18)
                                                            .shadow(color: Color(hex: "000000"), radius: 4, x: 0, y: 3)
                                                        HStack {
                                                            Text(show.name)
                                                                .font(.custom("Avenir", size: 23))
                                                                .fontWeight(.bold)
                                                                .foregroundColor(colorScheme == .light ? .black : .init(hex: "F2F2F2"))
                                                                .frame(width: 290, alignment: .leading)
                                                            Spacer()
                                                        }
                                                        
                                                        HStack {
                                                            Text(viewModel.returnGenresText(for: show.genres ?? []))
                                                                .font(.custom("Avenir", size: 15))
                                                                .fontWeight(.medium)
                                                                .foregroundColor(Color(hex: colorScheme == .light ? "777777" : "D0D0D0"))
                                                                .frame(width: 290, alignment: .leading)
                                                            Spacer()
                                                        }
                                                    }
                                                })
                                        }
                                    }.padding()
                                }.id(self.scrollViewID)

                            }
                            else {
                                VStack {
                                    Image(systemName: "tv")
                                        .resizable()
                                        .frame(width: 90, height: 70)
                                        .foregroundColor(Color(.darkGray))
                                    Text("Search for TV Shows \nor Movies!").multilineTextAlignment(.center)
                                        .font(.custom("Avenir", size: 22))
                                }.offset(y: UIScreen.main.bounds.height/2 - 235)
                            }
                        }
                        Spacer()
                    }.padding(.top, 30).offset(y: -40)
                }
            }.ignoresSafeArea(.keyboard, edges: .bottom)
        }.background(Color(.lightGray))
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .preferredColorScheme(.dark)
    }
}

