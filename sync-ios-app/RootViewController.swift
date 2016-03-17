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

public class RootViewController: UITableViewController {
    public var items: [ShoppingItem]!
    public var dataManager: DataManager!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO once Swift2.2 is released change selector
        //let sel = #selector(RootViewController.onDataUpdated(_))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("onDataUpdated:"), name: "kAppDataUpdatedNotification", object: nil)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func onDataUpdated(note: NSNotification) {
        print("::onDataUpdated::refresh tableview")
        items = dataManager.listItems()
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension RootViewController {
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let item = self.items[indexPath.row]
        if let itemName = item.name {
            cell?.textLabel?.text = itemName
        }
        if let itemDate = item.created {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            cell?.detailTextLabel!.text = formatter.stringFromDate(itemDate)
        }
        return cell!
    }
    public override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            dataManager.deleteItem(items[indexPath.row])
            tableView.reloadData()
        }
    }
}

// MARK: Segue
extension RootViewController {
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier where identifier == "showExistingItemDetails" {
            if let sender = sender as? UITableViewCell,
                cell = tableView.indexPathForCell(sender) {
                let dest = segue.destinationViewController as? DetailledViewController
                dest?.item = items[cell.row]
                dest?.dataManager = dataManager
            }
        } else if let identifier = segue.identifier where identifier == "showNewItemDetails" {
            let dest = segue.destinationViewController as? DetailledViewController
            dest?.item = dataManager.getItem()
            dest?.dataManager = dataManager
        }
    }
}