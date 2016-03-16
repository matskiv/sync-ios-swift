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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var syncClient: FHSyncClient!
    var dataManager: DataManager!
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let navController = self.window?.rootViewController as? UINavigationController
        navController?.navigationBar.barTintColor = UIColor.redColor()
        navController?.navigationBar.tintColor = UIColor.whiteColor()
        navController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        syncClient = FHSyncClient.getInstance()
        dataManager = DataManager()
        dataManager.syncClient = syncClient
        // TODO CoreData
        //dataManager.managedObjectContext = self.managedObjectContext
        
        let tableViewController = navController?.topViewController as? RootViewController
        tableViewController?.dataManager = dataManager
        
        FH.init {(resp: Response, error: NSError?) -> Void in
            if let error = error {
                print("FH init failed. Error = \(error)")
                if FH.isOnline == false {
                    print("Make sure you're online.")
                } else {
                    print("Please fill in fhconfig.plist file.")
                }
                return
            }
            print("initialized OK:: Starting SyncClient")
            self.dataManager.start()
        }        
        return true
    }
}

