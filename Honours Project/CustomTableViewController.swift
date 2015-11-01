//
//  CustomTableViewController.swift
//  Honours Project
//
//  Created by Calum on 01/11/2015.
//  Copyright © 2015 Gathergood. All rights reserved.
//

import UIKit

class CustomTableViewController: PFQueryTableViewController {

    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "PhotoTest"
        self.textKey = "user"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 15
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery{
        let query = PFQuery(className: "PhotoTest")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("customCell") as! CustomCell!
        if cell == nil {
            cell = CustomCell(style: UITableViewCellStyle.Default, reuseIdentifier: "customCell")
        }
        
        if let user = object?["user"] as? String {
            cell?.username?.text = user
        }
        
        if let platform = object?["platform"] as? String {
            cell?.platform?.text = platform
        }
        
        cell?.timestamp?.text = formatDate((object?.createdAt)!)
        
        
        
        let userImage = UIImage(named: "image")
        cell.postedImage!.image = userImage
        if let thumbnail = object?["image"] as? PFFile {
            cell.postedImage!.file = thumbnail
            cell.postedImage!.loadInBackground()
        }
        
        return cell
        
    }
    
    func formatDate(parseDate: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E MMM d hh:mm"
        let dateString = dateFormatter.stringFromDate(parseDate)
        return dateString
    }

    
}
