//
//  AllListTableViewController.swift
//  Checklists
//
//  Created by Graeme Kelly on 20/05/2015.
//  Copyright (c) 2015 Graeme Kelly. All rights reserved.
//

import UIKit

class AllListTableViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataModel.lists.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as? UITableViewCell

        // Configure the cell...
        let cellIdentifer = "Cell"
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifer)
        }
        
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .DetailDisclosureButton
        if (checklist.countUncheckedItems() > 0) {
            cell.detailTextLabel!.text = "\(checklist.countUncheckedItems()) Remaining"
        } else if (checklist.items.count == 0) {
            cell.detailTextLabel!.text = "(No Items)"
        } else {
             cell.detailTextLabel!.text = "All Done!"
        }
        
        cell.imageView!.image = UIImage(named: checklist.iconName)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let checklist = dataModel.lists[indexPath.row]
        dataModel.indexOfSelectedChecklist = indexPath.row
        //Moved this into the dataModel to manage the defaults
        //NSUserDefaults.standardUserDefaults().setInteger(indexPath.row, forKey: "ChecklistIndex")
        
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    
    //Once the controller has been returned you need to set the checklist on that controller with the sender.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destinationViewController as! CheckListViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }
    
    //Overide function that allows user to delete the checklists
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.lists.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("ListNavigationController") as! UINavigationController
        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = self
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        presentViewController(navigationController, animated: true, completion: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        //let index = NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        let index = dataModel.indexOfSelectedChecklist
        if (index >= 0 && index < dataModel.lists.count) {
            let checklist = dataModel.lists[index]
            performSegueWithIdentifier("ShowChecklist", sender: checklist)
        }
    }
    
    //Delegate methods for the List Detail View Controller
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController,
            didFinishAddingChecklist checklist: Checklist) {
            dataModel.lists.append(checklist)
            dataModel.sortChecklists()
            tableView.reloadData()
            dismissViewControllerAnimated(true, completion: nil)
    }
    func listDetailViewController(controller: ListDetailViewController,
            didFinishEditingChecklist checklist: Checklist) {
            dataModel.sortChecklists()
            tableView.reloadData()
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //Delegate for Navigation Controller
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if (viewController === self) {
            dataModel.indexOfSelectedChecklist = -1
            //NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "ChecklistIndex")
        }
    }
    
 }
