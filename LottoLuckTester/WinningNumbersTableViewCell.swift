//
//  WinningNumbersTableViewCell.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 11/1/21.
//

import UIKit

class WinningNumbersTableViewCell: UITableViewCell {

    @IBOutlet weak var num1TextView: UITextField!
    
    @IBOutlet weak var num2TextView: UITextField!
    
    @IBOutlet weak var num3TextView: UITextField!
    @IBOutlet weak var num4TextView: UITextField!
    @IBOutlet weak var num5TextView: UITextField!
    @IBOutlet weak var powerBallTextView: UITextField!
    @IBOutlet weak var moneyLabel: UILabel!
    
    // Ask JASON about putting initiliaztion code here:
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        num1TextView.isEnabled = false
        num2TextView.isEnabled = false
        num3TextView.isEnabled = false
        num4TextView.isEnabled = false
        num5TextView.isEnabled = false
        powerBallTextView.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
