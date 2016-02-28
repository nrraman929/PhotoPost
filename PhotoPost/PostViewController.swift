//
//  ViewController.swift
//  PhotoPost
//
//  Created by Nishant Raman on 2/26/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var selectedImageView: UIImageView!
    
    @IBOutlet weak var captionField: UITextField!

    @IBOutlet weak var postButton: UIButton!
    
    var media: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    
            self.dismissViewControllerAnimated(true) { () -> Void in
                self.selectedImageView.image = editedImage
            }
    }
    
    
    @IBAction func takePhoto(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        
            self.presentViewController(vc, animated: true, completion: nil)
        } else {
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func onPost(sender: AnyObject) {
        
        UserMedia.postUserImage(self.resize(selectedImageView.image!, newSize: CGSize(width: 160, height: 160)), withCaption: captionField.text) { (success: Bool, error: NSError?) -> Void in
            if success {
                print("got image")
            } else {
                print(error)
            }
        }
        
        //////////////////////////////////////////////////////////////////////
        
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                // do something with the data fetched
                self.media = media
                self.performSegueWithIdentifier("photosSegue", sender: self)
                
            } else {
                // handle error
                print(error)
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as? PhotosViewController
        vc!.media = media
        
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            if error == nil {
                
                self.dismissViewControllerAnimated(
                    true, completion: nil)
                print("logged out")
                
            } else {
                print(error)
            }
        }
    }


}

