//
//  ListDetailViewControllerTableViewController.swift
//  Checklists
//
//  Created by Graeme Kelly on 20/05/2015.
//  Copyright (c) 2015 Graeme Kelly. All rights reserved.
//

import UIKit


protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
        @IBOutlet weak var textField: UITextField!
        @IBOutlet weak var doneBarButton: UIBarButtonItem!
        weak var delegate: ListDetailViewControllerDelegate?
        var checklistToEdit: Checklist?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.rowHeight = 44
            if let checklist = checklistToEdit {
                title = "Edit Checklist"
                textField.text = checklist.name
                doneBarButton.enabled = true
            }
        }
        
        //Set the textField as the first responder so that when the screen loads the keyboard immediately appears.
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            textField.becomeFirstResponder()
        }
        
        @IBAction func cancel() {
            delegate?.listDetailViewControllerDidCancel(self)
        }
        
        @IBAction func done() {
            if let checklist = checklistToEdit {
                checklist.name = textField.text
                delegate?.listDetailViewController(self, didFinishEditingChecklist: checklist)
            } else {
                let checklist = Checklist(name: textField.text)
                delegate?.listDetailViewController(self, didFinishAddingChecklist: checklist)
            }
        }

        //Ensure the user cannot select the table cell with the text field embedded
        override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
                return nil
        }
        
        //Text field delegate method to determine if the text field has changed.
        func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            let oldText: NSString = textField.text
            let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
            doneBarButton.enabled = (newText.length > 0)
            return true
        }
}