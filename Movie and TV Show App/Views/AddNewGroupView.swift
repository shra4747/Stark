//
//  AddNewGroupView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/5/21.
//

import SwiftUI
import SFSymbolsPicker

struct AddNewGroupView: View {
    
    @StateObject var viewModel = AddNewGroupViewModel()
    @Environment(\.presentationMode) var dismissPage

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: viewModel.gradient), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .cornerRadius(18)
                        .opacity(0.6)
                        .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                        .shadow(color: Color(.darkGray), radius: 6)
                    VStack(spacing: 24) {
                        NavigationLink(
                            destination: ChooseIconView(icon: $viewModel.icon),
                            label: {
                                Text(viewModel.icon != "" ? viewModel.icon.suffix(1) : "-")
                                    .font(.system(size: 70))
                                    .frame(height: 30)
                                    .foregroundColor(.black)
                            })
                        Text(viewModel.groupName != "" ? viewModel.groupName : "---------")
                            .font(.custom("Avenir", size: 25))
                            .fontWeight(.medium)

                    }.offset(y: 5)
                }
                
                Button(action: {
                    viewModel.shuffleGradient()
                }) {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(.white)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .cornerRadius(18)
                            .opacity(0.6)
                            .frame(width: UIScreen.main.bounds.width - 120, height: 40)
                            .shadow(color: Color(.darkGray), radius: 3)
                        HStack(spacing: 15) {
                            Text("Shuffle Gradient")
                                .font(.custom("Avenir", size: 16))
                                .fontWeight(.medium)
                            Image(systemName: "shuffle")
                        }.offset(y: 0).foregroundColor(.black)
                    }
                }
                
                TextField("Group Name:", text: $viewModel.groupName)
                    .cornerRadius(18)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 20)
                        .shadow(radius: 5)
                    .frame(width: UIScreen.main.bounds.width - 80)
                    .multilineTextAlignment(.center)
                    .font(.custom("Avenir", size: 18))
                
                TextField("Icon:", text: $viewModel.icon)
                    .cornerRadius(18)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 20)
                        .shadow(radius: 5)
                    .frame(width: UIScreen.main.bounds.width - 80)
                    .multilineTextAlignment(.center)
                    .font(.custom("Avenir", size: 18))
                    
                
                Button(action: {
                    // Add New Group
                    viewModel.addButtonClicked()
                    dismissPage.wrappedValue.dismiss()
                }) {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [viewModel.gradient[0]]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .cornerRadius(18)
                            .opacity(0.6)
                            .frame(width: UIScreen.main.bounds.width - 75, height: 50)
                            .shadow(color: Color(.darkGray), radius: 8)
                        HStack(spacing: 15) {
                            Text("Add Group")
                                .font(.custom("Avenir", size: 17))
                                .fontWeight(.medium)
                            Image(systemName: "plus")
                        }.offset(y: 0).foregroundColor(.black)
                    }
                }
                
            }.navigationBarHidden(true)
        }
    }
}

struct AddNewGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGroupView()
    }
}
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
