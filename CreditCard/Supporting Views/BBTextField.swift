//
//  BBTextField.swift
//  CreditCard
//
//  Created by Berkant Beğdilili on 9.06.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct BBTextField : UIViewRepresentable {
    
    @Binding var text: String
    let characterLimit: Int?
    let keyboardType: UIKeyboardType
    let placeHolder: String?
    let isCardNumber:Bool
    
    let textField = UITextField(frame: CGRect(x:0, y:0, width: 100, height: 32))

    func makeUIView(context: UIViewRepresentableContext<BBTextField>) -> UITextField {
        textField.keyboardType = keyboardType
        
        if keyboardType == .default {
            textField.autocapitalizationType = .allCharacters
        }

        textField.placeholder = placeHolder
        textField.borderStyle = .roundedRect
        
        textField.delegate = context.coordinator
       
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<BBTextField>) {
        self.textField.text = text
    }

    func makeCoordinator() -> BBTextField.Coordinator {
        let coordinator = Coordinator(self)

        let toolbar = UIToolbar()
        toolbar.setItems([
            
            UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace
                , target: nil
                , action: nil
            )
            , UIBarButtonItem(
                title: "Done"
                , style: UIBarButtonItem.Style.done
                , target: coordinator
                , action: #selector(coordinator.TapDone)
            )
            ]
            , animated: true
        )
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()

        textField.inputAccessoryView = toolbar
        return coordinator
    }

    typealias UIViewType = UITextField

    class Coordinator: NSObject,UITextFieldDelegate {
        let owner: BBTextField
        private var subscriber: AnyCancellable

        init(_ owner: BBTextField) {
            self.owner = owner
            subscriber = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: owner.textField)
                .sink(receiveValue: { _ in
                
  
                    if owner.textField.text!.count > owner.characterLimit ?? 25{
                        owner.textField.text = String(owner.textField.text!.prefix(owner.characterLimit ?? 25))
                    }
                    
                    owner.$text.wrappedValue = owner.textField.text ?? ""
                    
                })
            
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
             if owner.isCardNumber {
                if owner.textField.text!.count == 4 && !string.isEmpty {
                       owner.textField.text!.insert(" ", at: owner.textField.text!.index(owner.textField.text!.startIndex, offsetBy: 4))
                   }
                   if owner.textField.text!.count == 9 && !string.isEmpty {
                       owner.textField.text!.insert(" ", at: owner.textField.text!.index(owner.textField.text!.startIndex, offsetBy: 9))
                   }
                   if owner.textField.text!.count == 14 && !string.isEmpty {
                       owner.textField.text!.insert(" ", at: owner.textField.text!.index(owner.textField.text!.startIndex, offsetBy: 14))
                   }
            }
            return true
        }

        @objc fileprivate func TapDone() {
            owner.textField.resignFirstResponder()
        }

    }
    
}

extension UITextField {
    @objc func toolBarButtonTapped(button:UIBarButtonItem) -> Void {
        self.resignFirstResponder()
    }
}

extension String {
  var isBackspace: Bool {
    let char = self.cString(using: String.Encoding.utf8)!
    return strcmp(char, "\\b") == -92
  }
}



