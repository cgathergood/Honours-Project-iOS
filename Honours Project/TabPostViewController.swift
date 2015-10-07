//
//  TabPostViewController.swift
//  Honours Project
//
//  Created by Calum on 07/10/2015.
//  Copyright © 2015 Gathergood. All rights reserved.
//

import UIKit

class TabPostViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func getPhoto(sender: AnyObject) {
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .Default) { action -> Void in
            let image = UIImagePickerController()
            image.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(image, animated: true, completion: nil)
        }
        actionSheetController.addAction(takePictureAction)
        
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose Exisiting Photo", style: .Default) { action -> Void in
            let image = UIImagePickerController()
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(image, animated: true, completion: nil)
        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    
    @IBAction func post(sender: AnyObject) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
