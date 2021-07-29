//
//  ContentView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/28/21.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            TextField("Query", text: $viewModel.query).textFieldStyle(RoundedBorderTextFieldStyle()).padding(5)
            
            Button(action: {
                viewModel.search()
            }) {
                Text("Search")
            }
            
            Carousel(cardWidth: 300, spacing: 10) {
                ForEach(0..<viewModel.results.count, id: \.self) { i in
                    if let model = viewModel.results[i] as? SearchModel.Movie {
                        CarouselCard {
                            Image(uiImage: model.poster_path?.loadImage() ?? UIImage()).resizable().frame(width: 300, height: 430).cornerRadius(30)
                        }
                    }
                    else if let model = viewModel.results[i] as? SearchModel.TVShow {
                        CarouselCard {
                            Image(uiImage: model.poster_path.loadImage()).resizable().frame(width: 300, height: 430).cornerRadius(30)
                        }
                    }
                }
            }

        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension String {
    func loadImage() -> UIImage {
        
        do {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(self)") else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        
        return UIImage()
    }
}

