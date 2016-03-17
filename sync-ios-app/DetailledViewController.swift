/*
* Copyright Red Hat, Inc., and individual contributors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit
import FeedHenry

public class DetailledViewController: UIViewController {
    var item: ShoppingItem!
    var action: String!
    var dataManager: DataManager!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createdTextField: UITextField!
    @IBOutlet weak var createdLabel: UILabel!
    
//    public var isUpdate: Bool {
//        if let uid = item.uid where uid != "" {
//            print("UID \(uid)")
//            return true
//        }
//        return false
//    }
    public override func viewDidLoad() {
        if let item = item {
            self.nameTextField.text = item.name
            self.createdLabel.hidden = false
            self.createdTextField.hidden = false
            if let created = item.created {
                let formatter = NSDateFormatter()
                formatter.dateStyle = NSDateFormatterStyle.LongStyle
                formatter.timeStyle = .MediumStyle
                self.createdTextField.text = formatter.stringFromDate(created)
            }
            
        } else {// create
            self.createdLabel.hidden = true
            self.createdTextField.hidden = true
        }
    }
    
    @IBAction func saveItem(sender: AnyObject) {
        if let name = self.nameTextField.text where name != "" {
            if let item = item {
                item.name = name
                item.created = NSDate()
                dataManager.updateItem(item)
                print("HIT CREATE > UPDATE BUTTON:: \(item)")
            } else {
                item = dataManager.getItem()
                item.name = name
                item.created = NSDate()
                dataManager.createItem(item)
                
                print("HIT CREATE > SAVE BUTTON:: \(item)")
            }
        } else {
            displayError("Name is required")
        }
        let parent = self.parentViewController as? UINavigationController
        parent?.popViewControllerAnimated(true)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        if let parent = self.parentViewController as? UINavigationController {
            parent.popViewControllerAnimated(true)
        }
    }
    
    func displayError(error: String) {
        let alert = UIAlertController(title: error, message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}