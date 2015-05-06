//
//  DetailViewController.swift
//  Blog Reader
//
//  Created by Richard Tyran on 4/27/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

