//
//  ActivityIndicatorExtension.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/1/21.
//

import Foundation
import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
