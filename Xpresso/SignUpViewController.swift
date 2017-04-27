//
//  SignUpViewController.swift
//  Xpresso
//
//  Created by Bharam,Kamala Priya on 4/1/17.
//  Copyright © 2017 Bharam,Kamala Priya. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Username.resignFirstResponder()
        pwd.resignFirstResponder()
        FName.resignFirstResponder()
        LName.resignFirstResponder()
        Email.resignFirstResponder()
        npwd.resignFirstResponder()
        return true
    }


    override func viewDidLoad() {
        Username.delegate = self
        pwd.delegate = self
        FName.delegate = self
        LName.delegate = self
        Email.delegate = self
        npwd.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
       
            moveTextField(textField: npwd, moveDistance: -220, up: true)
        
        
    }
    // keyboard hiddens
    func textFieldDidEndEditing(_ textField: UITextField) {
       
            moveTextField(textField: npwd, moveDistance: -220, up: false)
        
        
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
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    
    @IBAction func SignUp(_ sender: Any) {
      
        let imageData = UIImagePNGRepresentation(self.DP.image!)
        //create a parse file to store in cloud
        let parseImageFile = PFFile(name: "Image.png", data: imageData!)
        
       
 
        let user = PFUser()
        
        user.username = Username.text!
        
        user.password = pwd.text!
        
        user.email = Email.text!
        
         user["Image"] = parseImageFile
        
        // Signing up using the Parse API
        
        
        
        
        user.signUpInBackground {
            (success, error) -> Void in
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                self.alert(message: errorString!, title: "Error")
                
            } else {
                
                user.saveInBackground(block: { (d, NSError) in
                    if d {
                        let alert:UIAlertController = UIAlertController(title: "Success", message: "Registration Successful", preferredStyle: .alert)
                        
                        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .cancel, handler: {action in self.dismiss(animated: true, completion: nil)})
                        
                        alert.addAction(defaultAction)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        self.alert(message: "Some Thing went wrong on our side, Try Later", title: "Sorry!")
                    }
                })
                
                
                
            }
        }

        
    }
       func displayAlertWithTitle(_ title:String, message:String){
        
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var FName: UITextField!
    
    @IBOutlet weak var LName: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var pwd: UITextField!
    
    @IBOutlet weak var npwd: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var DP: UIImageView!
    
    @IBAction func DPButton(_ sender: UIButton) {
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        DP.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

}
