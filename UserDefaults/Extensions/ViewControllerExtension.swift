//
//  ViewControllerExtension.swift
//  ShowCase
//
//  Created by Rafael González on 12/08/23.
//

import Foundation
import UIKit

//MARK: UIPickerViewDataSource methods implementacion
extension ViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return appConstants.fontFamilyControlComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontDataFamily.count
    }
}

//MARK: UIPickerViewDelegate  methods implemetation
extension ViewController : UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fontDataFamily[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected row", row)
        currentFontFamily = fontDataFamily[row]
        textView.font = UIFont(name: currentFontFamily!, size: currentFontSize)
    }
}

//MARK: UITextViewDelegate methods implementation
extension ViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("Text changed!")
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("selected range: ",textView.text(in: textView.selectedTextRange!)!)
    }
    
}


