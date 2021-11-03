//
//  LuckyNumbersTableViewController.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/28/21.
//

import UIKit

class LuckyNumbersTableViewController: UITableViewController {
    
    var rowHeight = 100

    var result: LotterySimulationResult = LotterySimulationResult(pickedLottoNumbers: LottoNumbers(powerBall: 32, nums: [2,3,3,4,5]))
    
    let evenColor = UIColor.init(red: 224.0 / 255, green: 140 / 255, blue: 40 / 255, alpha: 1)
    let oldColor = UIColor.orange

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.winningLottoResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "luckynumber", for: indexPath) as! WinningNumbersTableViewCell
        
        let winningNumber: LottoResult = result.winningLottoResult[indexPath.row]
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = evenColor
        } else {
            cell.backgroundColor = oldColor
        }
                
        let numbers = winningNumber.numbers.nums
        
        cell.num1TextView.text = String(numbers[0])
        
        var highlightedNums: [Int] = []
        
        if (result.pickedLottoNumbers.nums.contains(numbers[0])) {
            cell.num1TextView.backgroundColor = .green
            cell.num1TextView.textColor = .white
            highlightedNums.append(numbers[0])
        }
        
        cell.num2TextView.text = String(numbers[1])
        
        if (result.pickedLottoNumbers.nums.contains(numbers[1]) && !highlightedNums.contains(numbers[1])) {
            cell.num2TextView.backgroundColor = .green
            cell.num2TextView.textColor = .white
            highlightedNums.append(numbers[1])
        }
        
        cell.num3TextView.text = String(numbers[2])
        
        if (result.pickedLottoNumbers.nums.contains(numbers[2])  && !highlightedNums.contains(numbers[2])) {
            cell.num3TextView.backgroundColor = .green
            cell.num3TextView.textColor = .white
            highlightedNums.append(numbers[2])
        }
        
        cell.num4TextView.text = String(numbers[3])
        
        if (result.pickedLottoNumbers.nums.contains(numbers[3]) && !highlightedNums.contains(numbers[3])) {
            cell.num4TextView.backgroundColor = .green
            cell.num4TextView.textColor = .white
            highlightedNums.append(numbers[3])
        }
        
        cell.num5TextView.text = String(numbers[4])
        
        if (result.pickedLottoNumbers.nums.contains(numbers[4]) && !highlightedNums.contains(numbers[4])) {
            cell.num5TextView.backgroundColor = .green
            cell.num5TextView.textColor = .white
            highlightedNums.append(numbers[4])
        }
        
        if (result.pickedLottoNumbers.powerBall == winningNumber.numbers.powerBall) {
            cell.powerBallTextView.backgroundColor = .green
            cell.powerBallTextView.textColor = .white
        }
        
        cell.powerBallTextView.text = String(winningNumber.numbers.powerBall)
        cell.moneyLabel.text = winningNumber.dollars.toMoney()

        cell.textLabel?.text = ""

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
