//
//  LottoNumberTextView.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/11/21.
//

import UIKit

class TextFieldNumberValidator: NSObject, UITextFieldDelegate {
    
    private let min: Int
    private let max: Int
    
    init( min: Int,  max: Int) {
        self.min = min
        self.max = max
        super.init()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let num = Int(textField.text!) else {
            textField.text = String(self.min)
            return;
        }
        
        if num < self.min {
            textField.text = String(self.min)
            return
        }
        
        if num > self.max {
            textField.text = String(self.max)
            return
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
