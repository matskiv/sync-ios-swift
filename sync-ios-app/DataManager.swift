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

import Foundation
import FeedHenry
public typealias ShoppingItem = [String: AnyObject]
public let DATA_ID = "myShoppingList"

public class DataManager: NSObject {
    public var syncClient: FHSyncClient!
    
    public func start() {
        let conf = FHSyncConfig()
        conf.syncFrequency = 30
        conf.notifySyncStarted = true
        conf.notifySyncCompleted = true
        conf.notifySyncFailed = true
        conf.notifyRemoteUpdateApplied = true
        conf.notifyRemoteUpdateFailed = true
        conf.notifyLocalUpdateApplied = true
        conf.notifyDeltaReceived = true
        conf.crashCountWait = 0;
        syncClient = FHSyncClient(config: conf)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("onSyncMessage:"), name:"kFHSyncStateChangedNotification", object:nil)
        //self.syncClient.manageWithDataId(DATA_ID, andConfig:nil, andQuery:[:])
        print("Start:TODO")
    }
    
    public func onSyncMessage(note: NSNotification) {
        //let msg = note.object as? FHSyncNotificationMessage
        //print("Got notification: \(msg)")
        print("onSyncMessage::TODO")
    }
    
    public func listItems() -> [ShoppingItem]? {
        print("listItems:TODO")
        return nil
    }
    
    public func createItem(item: ShoppingItem) -> ShoppingItem {
        print("createItem:TODO")
        return item
    }
    
    public func updateItem(item: ShoppingItem) -> ShoppingItem {
        print("updateItem:TODO")
        return item
    }
    
    public func deleteItem(item: ShoppingItem) -> ShoppingItem {
        print("deleteItem")
        return item
    }
    
    public func getItem() -> ShoppingItem {
        print("getItem:TODO")
        return [:]
    }
}