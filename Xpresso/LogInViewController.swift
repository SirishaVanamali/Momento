//
//  ViewController.swift
//  Xpresso
//
//  Created by Bharam,Kamala Priya on 3/6/17.
//  Copyright © 2017 Bharam,Kamala Priya. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController ,UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
       
        return true
    }

    override func viewDidLoad() {
        passwordTF.delegate = self
        usernameTF.delegate = self
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "images")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        moveTextField(textField: passwordTF, moveDistance: -220, up: true)
        
        
    }
    // keyboard hiddens
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        moveTextField(textField: passwordTF, moveDistance: -220, up: false)
        
        
    }
    // userdefined method to show animation for keyboard
    func moveTextField(textField: UITextField, moveDistance: Int, up:Bool)
    {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }

   
    @IBAction func unwindToA(sender: UIStoryboardSegue)
        
    {
        
        
        
        // Pull any data from the view controller which initiated the unwind segue.         print(viewControllerB)     }
        
        
        
    }
    
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var name = ""
    
    
    @IBAction func LogIn(_ sender: Any) {
    
        
    
        
//        let username = self.username.text!
//        let password = self.password.text!
        
        // let user = PFUser()
        
        PFUser.logInWithUsername(inBackground: usernameTF.text!, password: passwordTF.text!, block: {(user, error) -> Void in
            
            /*
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                self.alert(message: errorString!, title: "Error")
            }
            else {
                self.performSegue(withIdentifier: "profile", sender: nil)
                self.alert(message: "Welcome back!", title: "Login")
            }
            print("data was transfered")
 */
            
            if error != nil{
                //print(error)
                self.alert(message:"Mismatch", title: "Unsuccess")
            } else if user != nil {
                self.performSegue(withIdentifier: "profile", sender: nil)
            }
        })
    

}
    
    }
