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
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery{
        let query = PFQuery(className: "PhotoTest")
        return query
    }
    
}
