//
//  SettingsView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import SwiftUI
import AlertToast

struct SettingsView: View {
    
    @State var pickerBool = false
    @State var avatar = getImage(key: "__AVATAR__")
    @State var name = UserDefaults.standard.value(forKey: "__NAME__") as! String
    @State var named = ""
    
    @State var didTabDeleteGroups = false
    @State var didTapResetRatings = false
    @State var didTapDeleteSavedContent = false
    @Binding var didResetEverything: Bool
    @Environment(\.presentationMode) var dismissPage

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    pickerBool.toggle()
                }) {
                    VStack {
                        Image(uiImage: avatar!).resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle()).frame(width: 130, height: 130, alignment: .center).shadow(color: .black, radius: 5)
                        Text("Tap to Change Profile Picture")
                    }
                }.sheet(isPresented: $pickerBool) {
                    ImagePickerView(sourceType: .photoLibrary) { image in
                        self.avatar = image
                        setImage(image: image, key: "__AVATAR__")
                    }
                }.padding()

                Form {
                    Section(header: Text("Name")) {
                        TextField("Name", text: $name.onChanged({ changed in
                            if changed.count > 0 {
                                UserDefaults.standard.set(name, forKey: "__NAME__")
                            }
                        }))
                    }
                    Section(header: Text("Reset")) {
                        
                        Button(action: {
                            UserDefaults.standard.set(nil, forKey: "__FINISH__")
                            let stars = ["Mfive", "Mfour", "Mthree", "Mdislike", "Tfive", "Tfour", "Tthree", "Tdislike"]
                            for star in stars {
                                UserDefaults.standard.set(nil, forKey: "\(star)-star")
                            }
                            UserDefaults.standard.set(nil, forKey: "groups")
                            UserDefaults.standard.set(nil, forKey: "saved-001")
                            UserDefaults.standard.set(nil, forKey: "saved-002")
                            guard let savedGroupsData = UserDefaults.standard.data(forKey: "groups") else {
                                UserDefaults(suiteName: "group.com.shravanprasanth.movietvwidgetgroup")!.set(nil, forKey: "countdownsData")
                                UserDefaults(suiteName: "group.com.shravanprasanth.movietvwidgetgroup")!.set(nil, forKey: "countdownsData")
                                dismissPage.wrappedValue.dismiss()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    didResetEverything = true
                                }
                                return
                            }
                            
                            let decoded = try? JSONDecoder().decode([BookmarkGroupModel].self, from: savedGroupsData)
                            
                            if let decoded = decoded {
                                for group in decoded {
                                    UserDefaults.standard.set(nil, forKey: "saved-\(group.id)")
                                }
                            }
                            UserDefaults(suiteName: "group.com.shravanprasanth.movietvwidgetgroup")!.set(nil, forKey: "countdownsData")
                            dismissPage.wrappedValue.dismiss()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                didResetEverything = true
                            }
                        }) {
                            Text("Reset Everything (Onboarding)")
                        }
                        
                        Button(action: {
                            UserDefaults.standard.set(nil, forKey: "groups")
                            didTabDeleteGroups.toggle()
                        }) {
                            Text("Delete All Saved Groups")
                        }
                        
                        Button(action: {
                            let stars = ["Mfive", "Mfour", "Mthree", "Mdislike", "Tfive", "Tfour", "Tthree", "Tdislike"]
                            for star in stars {
                                UserDefaults.standard.set(nil, forKey: "\(star)-star")
                            }
                            didTapResetRatings.toggle()
                        }) {
                            Text("Reset All Ratings")
                        }
                        
                        Button(action: {
                            UserDefaults.standard.set(nil, forKey: "groups")
                            didTabDeleteGroups.toggle()
                        }) {
                            Text("Delete All Saved Groups")
                        }
                        
                        
                        Button(action: {
                            UserDefaults.standard.set(nil, forKey: "saved-001")
                            UserDefaults.standard.set(nil, forKey: "saved-002")
                            guard let savedGroupsData = UserDefaults.standard.data(forKey: "groups") else {
                                UserDefaults(suiteName: "group.com.shravanprasanth.movietvwidgetgroup")!.set(nil, forKey: "countdownsData")
                                
                                didTapDeleteSavedContent.toggle()
                                return
                            }
                            
                            let decoded = try? JSONDecoder().decode([BookmarkGroupModel].self, from: savedGroupsData)
                            
                            if let decoded = decoded {
                                for group in decoded {
                                    UserDefaults.standard.set(nil, forKey: "saved-\(group.id)")
                                }
                            }
                            UserDefaults(suiteName: "group.com.shravanprasanth.movietvwidgetgroup")!.set(nil, forKey: "countdownsData")

                            didTapDeleteSavedContent.toggle()
                        }) {
                            Text("Delete All Saved Content")
                        }
                    }
                    
                    
                    Section(header: Text("Credits")) {
                        Text("This product uses the TMDb API but is not endorsed or certified by TMDb.")
                        Link("https://www.themoviedb.org/", destination: URL(string: "https://www.themoviedb.org/")!)
                        HStack {
                            Image("tmdb")
                        }
                    }
                    
                    Section(header: Text("About")) {
                        Link("Privacy Policy", destination: URL(string: "https://www.craft.do/s/Cs2TbOrL5DQuRQ")!)
                        Link("Contact Support", destination: URL(string: "https://www.craft.do/s/s6fBFsB4xByZ3l")!)
                        Text("Clapboard app icon made by Freepik from https://www.flaticon.com")
                        Text("Stark - Version 1.1")
                        Text("Copyright © Shravan Prasanth")
                    }
                    
                }
            }.navigationBarHidden(true)
            .toast(isPresenting: $didTabDeleteGroups, duration: 2, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .complete(.green), title: "Success!", subTitle: "Deleted All Groups!", custom: .none)
            }
            .toast(isPresenting: $didTapResetRatings, duration: 2, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .complete(.green), title: "Reset!", subTitle: "Reset all Ratings!", custom: .none)
            }
            .toast(isPresenting: $didTapDeleteSavedContent, duration: 2, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .complete(.green), title: "Success!", subTitle: "Deleted All Saved Content!", custom: .none)
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
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
extension Binding {
    func onChanged(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

