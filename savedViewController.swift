
//  savedViewController.swift
//  Xpresso
//
//  Created by Vanamali,Sirisha on 4/13/17.
//  Copyright © 2017 Bharam,Kamala Priya. All rights reserved.
//

import UIKit
import Bolts
import Parse

class savedViewController: UIViewController, UITextFieldDelegate{
    

    override func viewDidLoad() {
        savedHeading.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        savedHeading.resignFirstResponder()
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

   
    //savetext=stockresults
    
    @IBOutlet weak var savedText: UITextView!
    
    @IBOutlet weak var savedHeading: UITextField!
    
    var ss: [PFObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
       let x = self.tabBarController?.viewControllers?[0] as! EntryFormController
       savedText.text! = x.first
        savedHeading.text! = x.second
    }


    
    @IBAction func FindStory(_ sender: Any) {
        let query = PFQuery(className:"Feelings")
        
        if savedHeading.text!.characters.count > 0 {
            query.whereKey("heading", equalTo:savedHeading.text!)
        } else {
            query.whereKeyExists("heading") // just fetch objects with this key (which is all of them)
        }
        
        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                
                self.displayAlertWithTitle("Success!", message:"Retrieved \(objects!.count) stories.")
                self.ss = objects!
                // Do something with the found objects
                //        self.savedText.text! = "\(ss.sto)"
                
                for sty in self.ss {
                    self.savedText.text! = "Story: \(sty["story"]!) \n Heading: \(sty["heading"]!)"
                }
                
                
            } else {
                // Log details of the failure
                self.displayAlertWithTitle("Oops", message: "\(error!) \(error!._userInfo)")
            }
            
            
        })
    }
    
//    @IBAction func find(_ sender: UIButton) {
//      
//        let query = PFQuery(className:"Feelings")
//       
//        if savedHeading.text!.characters.count > 0 {
//            query.whereKey("heading", equalTo:savedHeading.text!)
//        } else {
//            query.whereKeyExists("heading") // just fetch objects with this key (which is all of them)
//        }
//        
//        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
//            
//           if error == nil {
//                // The find succeeded.
//                
//                self.displayAlertWithTitle("Success!", message:"Retrieved \(objects!.count) scores.")
//                self.ss = objects!
//                // Do something with the found objects
////        self.savedText.text! = "\(ss.sto)"
//           
//            for sty in self.ss {
//                self.savedText.text! = "Story: \(sty["story"]!) \n Heading: \(sty["heading"]!)"
//            }
//            
//            
//            } else {
//                // Log details of the failure
//                self.displayAlertWithTitle("Oops", message: "\(error!) \(error!._userInfo)")
//            }
//            
//            
//        })
//    }
    
    func displayAlertWithTitle(_ title:String, message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
    }
}
