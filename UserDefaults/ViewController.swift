//
//  ViewController.swift
//  ShowCase
//
//  Created by Rafael González on 12/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var fontSizeControl: UISlider!
    @IBOutlet var fontColorControl: UIColorWell!
    @IBOutlet var fontFamilyControl: UIPickerView!
    
    var currentFontFamily = UIFont.familyNames.first
    var currentFontFamilyIndex = 0
    var currentFontSize = 17.0
    var currentFontRGBAColor = [CGFloat(128.0/255), CGFloat(128.0/255), CGFloat(128.0/255), CGFloat(1.0)]
    
    let fontDataFamily = UIFont.familyNames.prefix(20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontFamilyControl.delegate = self
        fontFamilyControl.dataSource = self
        textView.delegate = self
        // Do any additional setup after loading the view.
        textView.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        textView.textColor = UIColor(red: currentFontRGBAColor[0], green: currentFontRGBAColor[1], blue: currentFontRGBAColor[2], alpha: currentFontRGBAColor[3])

        //set an action for valueChanged method
        fontColorControl.addTarget(self, action: #selector(fontColorControlChanged), for: .valueChanged)
        
        print("NSS:", NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!)
        
        print("FMD:", FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //MARK: get value's properties
        currentFontFamily = getConfig(key: "savedFontFamily") as? String ?? currentFontFamily
        currentFontSize = getConfig(key: "savedFontSize") as? Double ?? currentFontSize
        currentFontRGBAColor = getConfig(key: "savedFontColor") as? [CGFloat] ?? currentFontRGBAColor
        currentFontFamilyIndex = getConfig(key: "savedFontFamilyIndex") as? Int ?? 0
        
        //MARK: set value's properties to text view
        textView.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        textView.textColor = UIColor(red: currentFontRGBAColor[0], green: currentFontRGBAColor[1], blue: currentFontRGBAColor[2], alpha: currentFontRGBAColor[3])
        
        //MARK: set components values
        fontSizeControl.value = Float(currentFontSize)
        fontColorControl.selectedColor = UIColor(red: currentFontRGBAColor[0], green: currentFontRGBAColor[1], blue: currentFontRGBAColor[2], alpha: currentFontRGBAColor[3])
        fontFamilyControl.selectRow(currentFontFamilyIndex, inComponent: 0, animated: true)
        fontFamilyControl.reloadAllComponents()
    }
    
    
    @IBAction func fontSizeChanged(_ sender: UISlider) {
        currentFontSize = Double(sender.value.rounded())
        textView.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        saveConfig(key: "savedFontSize", value: currentFontSize)
    }
    
    @objc func fontColorControlChanged(){
        currentFontRGBAColor = (fontColorControl.selectedColor?.cgColor.components!)!
        textView.textColor = fontColorControl.selectedColor
        saveConfig(key: "savedFontColor", value: currentFontRGBAColor)
    }
    
    
    
}

