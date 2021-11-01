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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
