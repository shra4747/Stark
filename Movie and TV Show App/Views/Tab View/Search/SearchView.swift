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
    @State private var textFieldId: String = UUID().uuidString
    
    @State var imageText = "tv"
    @State var text = "Search for TV Shows \nor Movies!"
    
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
                                        .id(textFieldId)
                                        .introspectTextField { uiTextField in
                                            uiTextField.attributedPlaceholder = NSAttributedString(string: "Search for anything...",
                                                                                                   attributes: [NSAttributedString.Key.foregroundColor: (colorScheme == .light ? UIColor.darkGray : UIColor.lightGray)])
                                        }
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                        .padding(5)
                                        .disableAutocorrection(true)
                                        .frame(width: UIScreen.main.bounds.width - 120, alignment: .leading)
                                        .padding(.leading, 10)
                                        .font(.custom("Avenir", size: 17))
                                        
                                        
                                }
                                Button(action: {
                                    if viewModel.query.count < 1 {
                                        return
                                    }
                                    textFieldId = UUID().uuidString
                                    viewModel.isLoading = true
                                    text = "No Results!"
                                    imageText = "xmark.octagon"
                                    
                                    DispatchQueue.main.async {
                                        scrollViewID = UUID()
                                        viewModel.search()
                                    }
                                    
                                }) {
                                    Image(systemName: "magnifyingglass")
                                        .scaleEffect(1.65)
                                        .foregroundColor(colorScheme == .light ? .black : Color(.lightGray))
                                        
                                }
                            }.padding()
                            Picker("", selection: $viewModel.selectedType.onTFChanged({ _ in
                                imageText = "tv"
                                text = "Search for TV Shows \nor Movies!"
                            })) {
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
                        ZStack {
                            if viewModel.isLoading {
                                ZStack {
                                    if colorScheme == .light {
                                        Color.init(hex: "EBEBEB")
                                    }
                                    else {
                                        Color.init(hex: "1A1A1A")
                                    }
                                    ActivityIndicator(isAnimating: $viewModel.isLoading)
                                }
                            }
                            if viewModel.selectedType == .movie {
                                if viewModel.movies.count != 0 {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .top, spacing: 22) {
                                            ForEach(viewModel.movies    , id: \.self) { movie in
                                                if movie.poster_path != "" || movie.poster_path != nil {
                                                    NavigationLink(
                                                        destination: MovieDetailView(id: movie.id, isGivingData: true, givingMovie: movie).navigationBarHidden(true),
                                                        label: {
                                                            VStack(alignment: .leading) {
                                                                Image(uiImage: ((movie.poster_path?.loadImage(type: .search, colorScheme: (colorScheme == .light ? .light : .dark)) ?? (colorScheme == .light ? UIImage(named: "SearchLight") : UIImage(named: "SearchDark")))!))
                                                                    .scaleEffect(((movie.poster_path ?? "") == "" ? 1 : 0.58))
                                                                    .frame(width: 220, height: 350)
                                                                    .cornerRadius(18)
                                                                    .shadow(color: Color(hex: colorScheme == .light ? "000000" : "6E6E6E"), radius: 5, x: 0, y: 3)
                                                                HStack {
                                                                    Text(movie.title)
                                                                        .font(.custom("Avenir", size: 22))
                                                                        .fontWeight(.bold)
                                                                        .foregroundColor(colorScheme == .light ? Color(.black) : .init(hex: "F2F2F2"))
                                                                        .frame(width:  220, alignment: .leading)
                                                                        .frame(maxHeight: 30)
                                                                    Spacer()
                                                                }
                                                                
                                                                HStack {
                                                                    Text(viewModel.returnGenresText(for: movie.genres))
                                                                        .font(.custom("Avenir", size: 16))
                                                                        .fontWeight(.medium)
                                                                        .foregroundColor(Color(hex: colorScheme == .light ? "777777" : "D0D0D0"))
                                                                        .frame(width:  220, alignment: .leading)
                                                                    Spacer()
                                                                }
                                                            }
                                                        })
                                                }
                                            }
                                        }.padding()
                                    }.id(self.scrollViewID).offset(y: -20)

                                }
                                else {
                                    if !viewModel.isLoading {
                                        ZStack {
                                            VStack {
                                                Image(systemName: imageText)
                                                    .resizable()
                                                    .frame(width: 90, height: imageText != "tv" ? 80 : 70)
                                                    .foregroundColor(colorScheme == .light ? Color(.darkGray) : Color(.lightGray))
                                                Text(text).multilineTextAlignment(.center)
                                                    .font(.custom("Avenir", size: 22))
                                            }
                                        }.offset(y: UIScreen.main.bounds.height/2 - 235)
                                    }
                                }
                            }
                            else {
                                if viewModel.shows.count != 0 {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .top, spacing: 22) {
                                            ForEach(viewModel.shows, id: \.self) { show in
                                                if show.poster_path != "" || show.poster_path != nil {
                                                    NavigationLink(
                                                        destination: TVShowDetailView(id: show.id, isGivingData: true, givingShow: show).navigationBarHidden(true),
                                                        label: {
                                                            VStack(alignment: .leading) {
                                                                Image(uiImage: ((show.poster_path?.loadImage(type: .search, colorScheme: (colorScheme == .light ? .light : .dark)) ?? (colorScheme == .light ? UIImage(named: "SearchLight") : UIImage(named: "SearchDark")))!))
                                                                    .scaleEffect(((show.poster_path ?? "") == "" ? 1 : 0.58))
                                                                    .frame(width: 220, height: 350)
                                                                    .cornerRadius(18)
                                                                    .shadow(color: Color(hex: "000000"), radius: 4, x: 0, y: 3)
                                                                HStack {
                                                                    Text(show.name)
                                                                        .font(.custom("Avenir", size: 23))
                                                                        .fontWeight(.bold)
                                                                        .foregroundColor(colorScheme == .light ? .black : .init(hex: "F2F2F2"))
                                                                        .frame(width:  220, alignment: .leading)
                                                                    Spacer()
                                                                }
                                                                
                                                                HStack {
                                                                    Text(viewModel.returnGenresText(for: show.genres ?? []))
                                                                        .font(.custom("Avenir", size: 15))
                                                                        .fontWeight(.medium)
                                                                        .foregroundColor(Color(hex: colorScheme == .light ? "777777" : "D0D0D0"))
                                                                        .frame(width:  220, alignment: .leading)
                                                                    Spacer()
                                                                }
                                                            }
                                                        })
                                                }
                                            }
                                        }.padding()
                                    }.id(self.scrollViewID).offset(y: -20)

                                }
                                else {
                                    if !viewModel.isLoading {
                                        VStack {
                                            Image(systemName: imageText)
                                                .resizable()
                                                .frame(width: 90, height: imageText != "tv" ? 80 : 70)
                                                .foregroundColor(colorScheme == .light ? Color(.darkGray) : Color(.lightGray))
                                            Text(text).multilineTextAlignment(.center)
                                                .font(.custom("Avenir", size: 22))
                                        }.offset(y: UIScreen.main.bounds.height/2 - 235)
                                    }
                                }
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

extension Binding {
    func onTFChanged(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
