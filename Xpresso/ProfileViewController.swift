//
//  ProfileViewController.swift
//  Xpresso
//
//  Created by Bharam,Kamala Priya on 4/17/17.
//  Copyright © 2017 Bharam,Kamala Priya. All rights reserved.
//

import UIKit
import Parse



class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        let HI:String = "Hey!!"
        UserName.text = HI + " " + (user?["username"] as? String)!
        let userImageFile = user?["Image"] as! PFFile
        
        
        userImageFile.getDataInBackground { (Success, Error) in
            if (Success != nil){
                let image = UIImage(data: Success!)
                self.ProfileImage.image = image!
                
            }
           
            
        }
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let imageData = UIImagePNGRepresentation(self.ProfileImage.image!)
        
        let parseImageFile = PFFile(name: "Image.png", data: imageData!)
        
        let user = PFUser.current()
        user?["Image"] = parseImageFile
        user?.saveInBackground(block: { (d, NSError) in
            if d {
                
            }
            else {
               
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func Logout(_ sender: Any) {
        PFUser.logOut()
        let login = storyboard?.instantiateInitialViewController()
        self.present(login!, animated: true, completion: {})
    }
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    
    @IBAction func ChangeButton(_ sender: UIButton) {
        
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
        //create a parse file to store in cloud
        
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        ProfileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
