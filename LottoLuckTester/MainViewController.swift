//
//  MainViewController.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/8/21.
//∫

import UIKit

class MainViewController: UIViewController {

    // has to declared here bcause it will be destroy in memory, because it's in the stack
    let lottoValidator = TextFieldNumberValidator(min: 1, max: 70)
    let lottoGoldValidator = TextFieldNumberValidator(min: 1, max: 25)
    let ticketValidator = TextFieldNumberValidator(min: 1, max: 1000)
    
    var running = false

    @IBOutlet weak var winningLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var totalJackpotLabel: UILabel!
    @IBOutlet weak var totalYearsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeTypeSegment: UISegmentedControl!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var ticketPerTextField: UITextField!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var lottoNum6: UITextField!
    @IBOutlet weak var lottoNum5: UITextField!
    @IBOutlet weak var lottoNum2: UITextField!
    @IBOutlet weak var lottoNum4: UITextField!
    @IBOutlet weak var lottoNum3: UITextField!
    @IBOutlet weak var lottoNum1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        lottoNum1?.delegate = lottoValidator
        lottoNum2?.delegate = lottoValidator
        lottoNum3?.delegate = lottoValidator
        lottoNum4?.delegate = lottoValidator
        lottoNum5?.delegate = lottoValidator
        lottoNum6?.delegate = lottoGoldValidator
        ticketPerTextField?.delegate = ticketValidator
        refreshButton.setTitle("", for: .normal)
        randomNumbers()
        changeButton("Play", color: .orange)
    }


    @IBAction func sliderYearChanged(_ sender: Any) {
        let years = round(yearSlider.value * 10) / 10
        
        yearLabel.text = "\(years) Million Years"
        yearSlider.setValue(years, animated: true)
    }
    
    @IBAction func onRefreshBtn(_ sender: Any) {
        randomNumbers()
    }
    
    func randomNumbers() {
        [lottoNum1, lottoNum2, lottoNum3, lottoNum4, lottoNum5, lottoNum6].forEach {
            $0.text = String(Int.random(in: 1..<76))
        }
    }

    @IBAction func playLotto(_ sender: Any) {
        if running == true {
            running = false
            clearOutput()
            return
        }
        guard let num1 = Int(lottoNum1.text ?? "1") else {
            return
        }
        guard let num2 = Int(lottoNum2.text ?? "1") else {
            return
        }
        guard let num3 = Int(lottoNum3.text ?? "1") else {
            return
        }
        guard let num4 = Int(lottoNum4.text ?? "1") else {
            return
        }
        guard let num5 = Int(lottoNum5.text ?? "1") else {
            return
        }
        
        guard let num6 = Int(lottoNum6.text ?? "1") else {
            return
        }
        
        guard let ticketsPerYear = Int(ticketPerTextField.text ?? "1") else {
            return
        }
        
        
        let years = Int((round(yearSlider.value * 10) / 10) * 1_000_000)
            
        
        let lottoCal = LotteryCalculator(num1: num1, num2: num2, num3: num3, num4: num4, num5: num5, powerNumber: num6)
        
        var lotteryResult = LotteryResult()
               
        var yearCount = 0;
        
        let queue = DispatchQueue(label: "calculator-queue")
        self.running = true
        changeButton("Stop", color: .red)

        queue.async {
            for i in 1...(ticketsPerYear * years) {
                lotteryResult = lottoCal.runLottery(result: lotteryResult)
                if self.running == false {
                    break
                }
                if i % (ticketsPerYear * 50) == 0 {
                    DispatchQueue.main.async {
                        yearCount += 50
                        
                        self.totalYearsLabel.text = "Years: \(yearCount.withCommas())"
                        self.totalJackpotLabel.text = "Jackpots: \(lotteryResult.jackPots())"
                        self.spentLabel.text = "Spent: \(lotteryResult.spent().toMoney())"
                        self.winningLabel.text = "Winnings: \(lotteryResult.totalWinning().toMoney())"
                    }
                }
            }
        }
    }
    
    func clearOutput() {
        totalYearsLabel.text = "Years: "
        totalJackpotLabel.text = "Jackpots: "
        spentLabel.text = "Spent: "
        winningLabel.text = "Winnings: "
        changeButton("Play", color: .orange)
    }
    
    func changeButton(_ text: String, color: UIColor) {
        let myNormalAttributedTitle = NSMutableAttributedString(string: text,
                                                         attributes: [
                                                            NSAttributedString.Key.foregroundColor : UIColor.white,
                                                            NSAttributedString.Key.font: UIFont(name: "PermanentMarker-Regular", size: 36.0) ?? UIFont.systemFont(ofSize:   36.0)
                                                         ])
        playButton.setAttributedTitle(myNormalAttributedTitle, for: .normal)
        playButton.layer.cornerRadius = 4
        playButton.layer.backgroundColor = color.cgColor
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
    func toMoney() -> String {
        let formatter = NumberFormatter()

        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.decimalSeparator = ","
        
        

        return formatter.string(from: NSNumber(value: self))!
    }
    
    
    
}


