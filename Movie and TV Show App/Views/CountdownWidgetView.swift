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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        switch widgetCase {
        case .small:
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 169, height: 169, alignment: .center)
                ZStack(alignment: .topLeading) {
                    Image(uiImage: widgetModel.poster_path.loadImage(type: .cast, colorScheme: (colorScheme == .light ? .light : .dark)))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 169, height: 169, alignment: .center)
                        .opacity(0.95)
                    
                    VStack(alignment: .leading) {
                        Text(widgetModel.title)
                            .font(.custom("Avenir", size: 22))
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        let date = CountdownDate().returnDaysUntil(dateString: widgetModel.release_date)
                        Text((date < 1) ? "Released" : "\(date) Day\((date > 1) ? "s" : "")")
                            .font(.custom("Avenir", size: 25))
                            .foregroundColor(.white)
                    }.padding()
                }.frame(width: 169, height: 169, alignment: .center)
            }.widgetURL(URL(string: "countdownwidget://\(widgetModel.id)"))
        case .medium:
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 360, height: 169, alignment: .center)
                ZStack(alignment: .topLeading) {
                    Image(uiImage: widgetModel.poster_path.loadImage(type: .cast, colorScheme: (colorScheme == .light ? .light : .dark)))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 360, height: 169, alignment: .center)
                        .opacity(0.95)
                    
                    VStack(alignment: .leading) {
                        Text(widgetModel.title)
                            .font(.custom("Avenir", size: 24))
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        let date = CountdownDate().returnDaysUntil(dateString: widgetModel.release_date)
                        Text((date < 1) ? "Released" : "\(date) Day\((date > 1) ? "s" : "")")
                            .font(.custom("Avenir", size: 25))
                            .foregroundColor(.white)
                    }.padding().padding(5)

                }.frame(width: 360, height: 169, alignment: .center)
            }.widgetURL(URL(string: "countdownwidget://\(widgetModel.id)"))
        case .large:
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 360, height: 376, alignment: .center)
                ZStack(alignment: .topLeading) {
                    Image(uiImage: widgetModel.poster_path.loadImage(type: .cast, colorScheme: (colorScheme == .light ? .light : .dark)))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 360, height: 376, alignment: .center)
                        .opacity(0.95)
                    
                    VStack(alignment: .leading) {
                        Text(widgetModel.title)
                            .font(.custom("Avenir", size: 30))
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        let date = CountdownDate().returnDaysUntil(dateString: widgetModel.release_date)
                        Text((date < 1) ? "Released" : "\(date) Day\((date > 1) ? "s" : "")")
                            .font(.custom("Avenir", size: 32))
                            .foregroundColor(.white)
                    }.padding(25)
                }.frame(width: 360, height: 376, alignment: .center)
            }.widgetURL(URL(string: "countdownwidget://\(widgetModel.id)"))
        }
    }
}

struct CountdownWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownWidgetView(widgetModel: WidgetModel(title: "Shang-Chi and the Legend of the Ten Rings", release_date: "2021-09-03", poster_path: "/9f2Q0U3IOsLgrI2HkvldwSABZy5.jpg"), widgetCase: .large)
    }
}

enum WidgetCase {
    case small, medium, large
}
