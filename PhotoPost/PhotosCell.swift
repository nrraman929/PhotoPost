//
//  PhotosCell.swift
//  PhotoPost
//
//  Created by Nishant Raman on 2/27/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit
import Parse

class PhotosCell: UITableViewCell {
    
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var media: PFObject! {
        didSet{
            let imageFile = media["media"] as! PFFile
            captionLabel.text = media["caption"] as? String
            imageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                self.pictureView.image = UIImage(data: data!)
                
            }
        }
    }
}
