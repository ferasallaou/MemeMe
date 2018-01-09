//
//  MemeViewController+Extension.swift
//  P2 MemeMe
//
//  Created by Feras Allaou on 1/8/18.
//  Copyright © 2018 Feras Allaou. All rights reserved.
//

import Foundation
import UIKit

// Delegate & Model Rep.
extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    struct MemeObj{
        var topText: String
        var lowerText: String
        var image: UIImage
        var memedImage: memedImage
    }
    
    struct memedImage{
        var memeImage: UIImage
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        // Only When the lower Keyboard Will Appear
        if textField.tag == 1{
            listenToKeyboardShow()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            textField.text = "Enter your text"
        }
        
        // Only When the lower Keyboard Will Disappear
        if textField.tag == 1{
            listenToKeyboardHide()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func listenToKeyboardShow(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(_ notification: Notification){
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    func listenToKeyboardHide(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        let info = notification.userInfo
        let keyboardSize = info![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        shareButtonOutlet.isEnabled = true
        let imgURL = info[UIImagePickerControllerOriginalImage]!
        mainImageView.image = imgURL as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
