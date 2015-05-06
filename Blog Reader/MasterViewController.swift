//
//  MasterViewController.swift
//  Blog Reader
//
//  Created by Richard Tyran on 4/27/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = "http://www.googleapis.com/blogger/v3/blogs/10861780/posts?key=AIzaSyADQHZF8izxdatmkwnSPetRHgqXxVXdeBE"
        
        let url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
    
            if (error != nil) {
                
                println(error)
                
            } else {
                
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                let results = jsonResult["items"] as NSArray
                var items = [[String: String]()]
                var item: AnyObject
                
                for var i = 0; i < results.count; ++i {
                    items.append([String:String]())
                    item = results[i] as NSDictionary
                    items[i]["content"] = item["content"] as? String
                    items[i]["title"] = item["title"] as? String
                    items[i]["publishedDate"] = item["published"] as? String
                    var authorDictionary = item["author"] as NSDictionary
                    items[i]["author"] = authorDictionary["displayName"] as? String
                
                }
                
                println(items)
                
            }
            
        })
        
        task.resume()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {

    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
//            let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
//                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "Blog Item"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}

