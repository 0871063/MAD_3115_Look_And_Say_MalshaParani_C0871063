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
    var actualNumber : String = ""
    
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
            self.actualNumber = ""
        }
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func separateDigitleft(number:Int)->Int{
        var numberArray = number.digits
        let removedNumber = numberArray.removeFirst()
        
        var numberString = ""
        for x in numberArray {
            numberString += String(x)
        }
        numberInt = Int(numberString) ?? 0
        
        return removedNumber;
    }
    
    private func look_and_say(number:Int){
        if number == 0 {
            showAlert(title: "Actual Number", actionTitle: "OK", message: "You actual number is \(actualNumber)", preferredStyle: .alert)
        }else{
            var x = separateDigitleft(number: number)
            say_digit(number: x)
            look_and_say(number: numberInt)
        }
        
    }
    
    private func add_digit_right(number:Int){
        actualNumber += String(number)
    }
    
    private func say_digit(number:Int){
        var convertedNumber = 0
        convertedNumber = number - 1
        add_digit_right(number: convertedNumber)
    }
    
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

