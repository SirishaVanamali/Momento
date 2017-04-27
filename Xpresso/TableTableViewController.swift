//
//  TableTableViewController.swift
//  Xpresso
//
//  Created by Vanamali,Sirisha on 4/18/17.
//  Copyright © 2017 Bharam,Kamala Priya. All rights reserved.
//

import UIKit
import Parse
import Bolts

var expressions: [PFObject] = []

class TableTableViewController: UITableViewController {
    var heading:[String] = []
    var story:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         heading = []
         story = []

        let query = PFQuery(className: "Feelings")
        
        query.findObjectsInBackground{
            (objects, error) -> Void in
            if error == nil {
                
                
                // Looping through the objects to get the names of the workers in each object
                for object in objects! {
                    let head = object["heading"]
                   
                    self.heading.append(head as! String)
                    let sto = object["story"]
                    self.story.append(sto as! String)
                     self.tableView.reloadData()
                    
                }
            }
            
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heading.count
    }
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if heading[indexPath.row] == "The Best" {
            cell.backgroundColor = UIColorFromRGB(rgbValue: 0xF2F05E)
        }
        else if heading[indexPath.row] == "Okay" {
            cell.backgroundColor = UIColorFromRGB(rgbValue: 0x6D4691)
        }
        else if heading[indexPath.row] == "Really Good" {
            cell.backgroundColor = UIColorFromRGB(rgbValue: 0x205396)
        }
        else if heading[indexPath.row] == "Meh" {
            cell.backgroundColor = UIColorFromRGB(rgbValue: 0x20966e)
        }
        else if heading[indexPath.row] == "Not so Great" {
            cell.backgroundColor = UIColorFromRGB(rgbValue: 0x964b20)
        }
        else{
            cell.backgroundColor = UIColorFromRGB(rgbValue: 0x963720)
        }
        
        
        cell.textLabel?.text = heading[indexPath.row]
        cell.detailTextLabel?.text = story[indexPath.row]
        
        
        
        return cell;
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
