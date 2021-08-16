//
//  CountdownWidgetView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/16/21.
//

import SwiftUI

struct CountdownWidgetView: View {
    
    @State var widgetModel: WidgetModel
    @State var widgetCase: WidgetCase
    
    var body: some View {
        switch widgetCase {
        case .small:
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 169, height: 169, alignment: .center)
                ZStack(alignment: .topLeading) {
                    Image(uiImage: widgetModel.poster_path.loadImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 169, height: 169, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .opacity(0.8)
                    
                    VStack(alignment: .leading) {
                        Text(widgetModel.title)
                            .font(.custom("Avenir", size: 22))
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: .white, radius: 10)
                        Spacer()
                        Text("\(CountdownDate().returnDaysUntil(dateString: widgetModel.release_date)) Days")
                            .font(.custom("Avenir", size: 25))
                            .foregroundColor(.white)
                            .shadow(color: .white, radius: 10)
                    }.padding()
                }.frame(width: 169, height: 169, alignment: .center)
            }
        case .medium:
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 360, height: 169, alignment: .center)
                ZStack(alignment: .topLeading) {
                    Image(uiImage: widgetModel.poster_path.loadImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 360, height: 169, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .opacity(0.8)
                    
                    VStack(alignment: .leading) {
                        Text(widgetModel.title)
                            .font(.custom("Avenir", size: 22))
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: .white, radius: 10)
                        Spacer()
                        Text("\(CountdownDate().returnDaysUntil(dateString: widgetModel.release_date)) Days")
                            .font(.custom("Avenir", size: 25))
                            .foregroundColor(.white)
                            .shadow(color: .white, radius: 10)
                    }.padding()
                }.frame(width: 360, height: 169, alignment: .center)
            }
        case .large:
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 360, height: 376, alignment: .center)
                ZStack(alignment: .topLeading) {
                    Image(uiImage: widgetModel.poster_path.loadImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 360, height: 376, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .opacity(0.8)
                    
                    VStack(alignment: .leading) {
                        Text(widgetModel.title)
                            .font(.custom("Avenir", size: 28))
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: .white, radius: 10)
                        Spacer()
                        Text("\(CountdownDate().returnDaysUntil(dateString: widgetModel.release_date)) Days")
                            .font(.custom("Avenir", size: 32))
                            .foregroundColor(.white)
                            .shadow(color: .white, radius: 10)
                    }.padding(25)
                }.frame(width: 360, height: 376, alignment: .center)
            }
        }
    }
}

struct CountdownWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownWidgetView(widgetModel: WidgetModel(title: "Eternals", release_date: "2021-11-05", poster_path: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"), widgetCase: .small)
    }
}

enum WidgetCase {
    case small, medium, large
}
