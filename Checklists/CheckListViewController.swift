//
//  ViewController.swift
//  Checklists
//
//  Created by Graeme Kelly on 14/05/2015.
//  Copyright (c) 2015 Graeme Kelly. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as! UITableViewCell
        let label = cell.viewWithTag(1000) as! UILabel
        if indexPath.row % 5 == 0 {
            label.text = "Walk the Dog"
        } else if (indexPath.row % 5 == 1) {
            label.text = "Brush my teeth"
        } else if (indexPath.row % 5 == 2) {
            label.text = "Learn iOS Development"
        } else if (indexPath.row % 5 == 3) {
            label.text = "Soccer practice"
        } else if (indexPath.row % 5 == 4) {
            label.text = "Eat ice cream"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .None {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

