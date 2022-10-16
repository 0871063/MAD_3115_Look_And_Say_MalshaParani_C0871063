//
//  ViewController.swift
//  MAD_3115_Look_And_Say_MalshaParani_C0871063
//
//  Created by Malsha Lambton on 2022-10-15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var actualNumberTextField: UITextField!
    
    var numberInt : Int = 0
    var iterationCount : Int = 0
    var actualNumber : Int = 0
    var nextcount : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateNumber() {
        numberInt = Int(actualNumberTextField.text ?? "0") ?? 0
        if numberInt <= 0 {
            showAlert(title: "Error", actionTitle: "OK", message: "Please enter a number greater than 0", preferredStyle: .alert)
        }else{
            look_and_say(number: numberInt)
        }
    }
    
    private func showAlert(title : String, actionTitle : String, message : String, preferredStyle : UIAlertController.Style){
        
        let alert = UIAlertController(title:title , message:message , preferredStyle: preferredStyle)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true){
            self.actualNumberTextField.text = ""
            self.numberInt = 0
            self.actualNumber = 0
            self.iterationCount = 0
            self.nextcount = 0
        }
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func separate_digit_left(number:Int)->Int{
        var numberArray = number.digits
        let removedNumber = numberArray.removeFirst()
        var numberString = ""
        
        for selectedNumber in numberArray {
          numberString += String(selectedNumber)
        }
        numberInt = Int(numberString) ?? 0
        if numberArray.count > 0 {
            iterationCount = numberArray[0]
            return removedNumber;
        }else{
            iterationCount = 0
            return 0;
        }
    }
    
    private func look_and_say(number:Int){
        if number == 0 {
            showAlert(title: "Actual Number", actionTitle: "OK", message: "You actual number is \(actualNumber)", preferredStyle: .alert)
            actualNumber = 0
            numberInt = 0
        }else{
            let removerdNumber =  separate_digit_left(number: number)
            if removerdNumber != 0 {
                actualNumber = removerdNumber
            }
            if iterationCount > 0 {
                for _ in 1...iterationCount {
                    say_digit(number: actualNumber)
                }
            }
            nextcount = 0
            look_and_say(number: numberInt)
        }
    }

    private func add_digit_right(numberAdd:Int, numberCount : Int){
        let displayNumber = String(numberCount) + String(numberAdd)
        if actualNumber > 0 {
            let combinedNumber = String(actualNumber) + displayNumber
            actualNumber = Int(combinedNumber) ?? 0
        }else{
            actualNumber = Int(displayNumber) ?? 0
        }
        nextcount = 1
    }
    
    private func say_digit(number:Int){
        let numberArray = number.digits
        var index = 0
        actualNumber = 0
        for selectedNumber in numberArray {
            var nextIndex = index + 1
            nextIndex = numberArray.indices.contains(nextIndex) ? nextIndex : 0
            if nextIndex != 0 {
                if selectedNumber != numberArray[nextIndex] {
                    add_digit_right(numberAdd:selectedNumber, numberCount :nextcount)
                }else{
                    nextcount += 1
                }
                index += 1
            }else{
                add_digit_right(numberAdd:selectedNumber, numberCount :nextcount)
            }
        }
    }
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

