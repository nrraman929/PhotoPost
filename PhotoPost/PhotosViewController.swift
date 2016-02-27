//
//  PhotosViewController.swift
//  PhotoPost
//
//  Created by Nishant Raman on 2/27/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit
import Parse

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var cell: PhotosCell!
    
    var media: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("photosCell", forIndexPath: indexPath) as! PhotosCell
        
        cell.media = media![indexPath.row]
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let m = self.media {
            return m.count
        } else {
            return 0
        }
    }

}
