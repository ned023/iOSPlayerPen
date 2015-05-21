//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Graeme Kelly on 18/05/2015.
//  Copyright (c) 2015 Graeme Kelly. All rights reserved.
//

import UIKit

//Defines a set of methods for a delegate - equiavlent to an interface
protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    var itemToEdit: ChecklistItem?
    
    //You need to hold the delegate on the controller
    weak var delegate: ItemDetailViewControllerDelegate?

    
    //Disable selection of row - otherwise it will grey out
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //Force keyboard to show by setting textField as first Responder
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneButton.enabled = true
        }
    }

    @IBAction func cancel() {
        //dismissViewControllerAnimated(true, completion: nil)
        delegate?.itemDetailViewControllerDidCancel(self)
    }

    @IBAction func done() {
       // println("Contents of the text field: \(textField.text)")
       // dismissViewControllerAnimated(true, completion: nil)
        if let item = itemToEdit {
            item.text = textField.text
            
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text
            item.checked = false
        
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text
        //This function is a delegate of UITextField and will only return the range and actual replacement string within the actual string.  The following
        //line determines what the new text would be by replacing the characters based on the range.
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneButton.enabled = newText.length > 0
        return true
    }
}
