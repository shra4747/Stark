//
//  EmojiTextFieldExtension.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/7/21.
//

import Foundation
import SwiftUI
import UIKit

class UIEmojiTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
    
    override var textInputContextIdentifier: String? {
           return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default // do not remove this
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        if text.count > 1 {
            uiView.text = String(text.suffix(1))
        }
        else if text.count == 1 {
            uiView.text = String(text)
        }
        else if text.count == 0 {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                
                if textField.text?.count ?? 0 > 1 {
                    self?.parent.text = String(textField.text?.suffix(1) ?? "")
                }
                if textField.text?.count ?? 0 == 1 {
                    self?.parent.text = String(textField.text ?? "")
                }
                else if textField.text?.count == 0 {
                    self?.parent.text = textField.text ?? ""
                }
                
            }
        }
    }
}
