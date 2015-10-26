//
//  TabFeedViewController.swift
//  Honours Project
//
//  Created by Calum on 11/10/2015.
//  Copyright © 2015 Gathergood. All rights reserved.
//

import UIKit

class TabFeedViewController: UITableViewController {
    
    var platforms = [String]()
    var users = [String]()
    var timestamps = [String]()
    var imageFiles = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className:"PhotoTest")
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                if(objects!.count > 0) {
                    for object in objects! {
                        self.users.append(object["user"] as! String)
                        self.platforms.append(object["platform"] as! String)
                        self.timestamps.append(self.formatDate(object.createdAt!))
                        self.imageFiles.append(object["image"] as! PFFile)
                        self.tableView.reloadData()
                    }
                }

            } else {
                // Log details of the failure
                print(error)
            }
        }  
        
    }
    
    func formatDate(parseDate: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E MMM d hh:mm"
        let dateString = dateFormatter.stringFromDate(parseDate)
        return dateString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! Cell

        cell.postedImage.image = UIImage(named: "camera_large.png")
        cell.username.text = users[indexPath.row]
        cell.platform.text = platforms[indexPath.row]
        cell.timestamp.text = timestamps[indexPath.row]

        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock{
            (imageData, error) -> Void in
            
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.postedImage.image = image
            }
            
        }
        
        return cell
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure you wish to logout?", preferredStyle: UIAlertControllerStyle.Alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            PFUser.logOut()
            self.view.window?.rootViewController = self.storyboard?.instantiateInitialViewController()
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        presentViewController(logoutAlert, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
