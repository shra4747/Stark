//
//  SettingsView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import SwiftUI

struct SettingsView: View {
    
    @State var pickerBool = false
    @State var images: [UIImage] = []
    @State var image = UIImage()
    var body: some View {
        VStack {
            Button(action: {
                pickerBool.toggle()
            }) {
                Image(uiImage: image).resizable()
                    .clipShape(Circle()).frame(width: 80, height: 80, alignment: .center).shadow(radius: 5)
            }.sheet(isPresented: $pickerBool) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.image = image
                    if let encoded = try? JSONEncoder().encode(self.image.pngData()) {
                        UserDefaults.standard.set(encoded, forKey: "profile_picture")
                    }
                }
            }
            .onAppear {
                guard let data = UserDefaults.standard.data(forKey: "profile_picture") else {
                    return
                }
                if let savedImage = UIImage(data: data) {
                    self.image = savedImage
                }
            }
            Form {
                Section {
                    Button(action: {
                        
                    }) {
                        Text("Delete all data to recommend content")
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
import UIKit
import Photos
import PhotosUI

public struct ImagePickerView: UIViewControllerRepresentable {

    private let sourceType: UIImagePickerController.SourceType
    private let onImagePicked: (UIImage) -> Void
    @Environment(\.presentationMode) private var presentationMode

    public init(sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
        self.sourceType = sourceType
        self.onImagePicked = onImagePicked
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagePicked: self.onImagePicked
        )
    }

    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void

        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagePicked(image)
            }
            self.onDismiss()
        }

        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }

    }

}