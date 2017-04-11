# sync-ios-swift
[![Build Status](https://travis-ci.org/feedhenry-templates/sync-ios-swift.png)](https://travis-ci.org/feedhenry-templates/sync-ios-swift)

> ObjC version is available [here](https://github.com/feedhenry-templates/sync-ios-app).

Author: Corinne Krych   
Level: Intermediate  
Technologies: Swift 3, iOS, RHMAP, CocoaPods. 
Summary: A demonstration of how to synchronize a single collection with RHMAP. 
Community Project : [Feed Henry](http://feedhenry.org) 
Target Product: RHMAP  
Product Versions: RHMAP 3.7.0+   
Source: https://github.com/feedhenry-templates/sync-ios-app  
Prerequisites: fh-ios-swift-sdk : 5+, Xcode : 8+, iOS SDK : iOS8+, CocoaPods: 1.1.0+

## What is it?

This application manages items in a collection that is synchronized with a remote RHMAP cloud application.  The user can create, update, and delete collection items.  Refer to `sync-ios-app/fhconfig.plist` for the relevant pieces of code and configuraiton.

If you do not have access to a RHMAP instance, you can sign up for a free instance at [https://openshift.feedhenry.com/](https://openshift.feedhenry.com/).

## How do I run it?  

### RHMAP Studio

This application and its cloud services are available as a project template in RHMAP as part of the "Sync Framework Project" template.

### Local Clone (ideal for Open Source Development)
If you wish to contribute to this template, the following information may be helpful; otherwise, RHMAP and its build facilities are the preferred solution.

## Build instructions

1. Clone this project
1. Populate ```sync-ios-app/fhconfig.plist``` with your values as explained [here](https://access.redhat.com/documentation/en-us/red_hat_mobile_application_platform/4.3/html/client_sdk/native-ios-swift#native-ios-swift-setup).
1. Run ```pod install``` 
1. Open sync-ios-app.xcworkspace
1. Run the project
 
## How does it work?

### Start synchronization

In ```sync-ios-app/DataManager.swift``` the synchronization loop is started.
```
    let conf = FHSyncConfig()
    conf.syncFrequency = 30
    conf.notifySyncStarted = true
    conf.notifySyncCompleted = true
    ...
    syncClient = FHSyncClient(config: conf) // [1]
    NotificationCenter.default.addObserver(self,
            selector:#selector(DataManager.onSyncMessage(_:)),
            name:Notification.Name(rawValue: "kFHSyncStateChangedNotification"),
            object:nil) // [2]
    syncClient.manage(withDataId: DATA_ID, andConfig:nil, andQuery:[:]) // [3]
```
[1] Initialize with sync configuration.

[2] Register to listen to ```kFHSyncStateChangedNotification``` event. Trigger ```onSyncMessage:``` as a callback.

[3] Initialize a sync client for a given dataset.

### Listening to sync notification to hook in 
In ```sync-ios-app/DataManager.swift``` the method ```onSyncMessage``` is your callback method on sync events.

```
public func onSyncMessage(_ note: Notification) {
    if let msg = note.object as? FHSyncNotificationMessage, let code = msg.code {
        print("Got notification: \(msg)")
        if code == REMOTE_UPDATE_APPLIED_MESSAGE { 
            // Add UI / business code
        }
    }
}
```
