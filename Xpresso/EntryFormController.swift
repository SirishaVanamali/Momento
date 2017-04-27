//
//  EntryFormController.swift
//  Xpresso
//
//  Created by Vanamali,Sirisha on 4/12/17.
//  Copyright © 2017 Bharam,Kamala Priya. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Parse
import Bolts
//var picker:UIPickerView!
let feelings = ["The Best","Really Good","Okay","Meh","Not so Great","The Worst"]

class EntryFormController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
        
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var SelectLBL: UILabel!
    
    @IBOutlet weak var textLBL: UITextView!
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return feelings.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return feelings[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectLBL.text = feelings[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLBL.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
       // picker.frame = CGRect(x: 45, y: 160, width: 286, height: 291)
       // picker.alpha = 1
       // picker.isHidden = false
        //picker.isUserInteractionEnabled = true
       // view.addSubview(picker)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textLBL.text = ""
        moveTextView(textView: textLBL, moveDistance: -180, up: true)
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textLBL.text == "" {
            textLBL.text = "Enter Text"
        }
        moveTextView(textView: textLBL, moveDistance: -180, up: false)
    }
    func moveTextView(textView: UITextView, moveDistance: Int, up:Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    var first = ""
    var second = ""
    var expressions: [PFObject] = []
    
    @IBAction func saveButton(_ sender: UIButton) {
        let expression = PFObject(className: "Feelings")
        first = textLBL.text
        second = SelectLBL.text!
        
        expression["story"] = textLBL.text
        expression["heading"] = SelectLBL.text
        
        expression.saveInBackground(block: { (success, error) -> Void in
            print("Story has been saved.")
            self.displayAlertWithTitle("Success!", message:"Saved your Entry into your Journal.")
            
        })
    }
    func displayAlertWithTitle(_ title:String, message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    

    
    
}
