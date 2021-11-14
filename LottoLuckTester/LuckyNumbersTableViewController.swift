//
//  LuckyNumbersTableViewController.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/28/21.
//

import UIKit

class LuckyNumbersTableViewController: UITableViewController {
    
    var rowHeight = 100

    var result: LotterySimulationResult = LotterySimulationResult(pickedLottoNumbers: LottoNumbers(powerBall: 32, nums: [2,3,3,4,5]), ticketsPerYear: 1)
    
    let evenColor = UIColor.init(red: 224.0 / 255, green: 140 / 255, blue: 40 / 255, alpha: 1)
    let oldColor = UIColor.orange

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.winningLottoResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "luckynumber", for: indexPath) as! WinningNumbersTableViewCell
        
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = evenColor
        } else {
            cell.backgroundColor = oldColor
        }
        
        let winningNumber: LottoResult = result.winningLottoResult[indexPath.row]
        
        
        cell.num1TextView.text = String(winningNumber.numbers.nums[0].number)
        cell.num2TextView.text = String(winningNumber.numbers.nums[1].number)
        cell.num3TextView.text = String(winningNumber.numbers.nums[2].number)
        cell.num4TextView.text = String(winningNumber.numbers.nums[3].number)
        cell.num5TextView.text = String(winningNumber.numbers.nums[4].number)
        cell.powerBallTextView.text = String(winningNumber.numbers.powerBall.number)
        cell.moneyLabel.text = winningNumber.dollars.toMoney()

        cell.textLabel?.text = ""

        highlightWinningNumber(cell.num1TextView, winningNumber.numbers.nums[0].isMatch)
        highlightWinningNumber(cell.num2TextView, winningNumber.numbers.nums[1].isMatch)
        highlightWinningNumber(cell.num3TextView, winningNumber.numbers.nums[2].isMatch)
        highlightWinningNumber(cell.num4TextView, winningNumber.numbers.nums[3].isMatch)
        highlightWinningNumber(cell.num5TextView, winningNumber.numbers.nums[4].isMatch)
        highlightWinningNumber(cell.num5TextView, winningNumber.numbers.nums[4].isMatch)
        highlightWinningNumber(cell.powerBallTextView, winningNumber.numbers.powerBall.isMatch, true)

        return cell
    }
    
    func highlightWinningNumber(_ textView: UITextField, _ numberWon: Bool,_ isPowerBall: Bool = false) {
        if numberWon {
            textView.backgroundColor = .systemGreen
            textView.textColor = .white
        } else if isPowerBall {
            textView.backgroundColor = .black
            textView.textColor = .white
        } else {
            textView.backgroundColor = .white
            textView.textColor = .black
        }
    }

}
