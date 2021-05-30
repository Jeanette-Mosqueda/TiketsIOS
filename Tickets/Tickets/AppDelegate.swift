//
//  AppDelegate.swift
//  Tickets
//
//  Created by user182859 on 5/30/21.
//  Copyright © 2021 user182859. All rights reserved.
//

import UIKit
import SQLite3

var dbQueue:OpaquePointer!

var dbURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dbQueue = createAndOpenDatabase()//create and open database
        
        if(createTables() == false)
        {
            print("Error in Creating Tables")
        }
        else
        {
            print("YAY table create")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func createAndOpenDatabase() -> OpaquePointer?
    {
        var db: OpaquePointer?
        
        let url = NSURL(fileURLWithPath: dbURL)
        
        if let pathComponent = url.appendingPathComponent("tickets.sqlite")
        {
            let filePath = pathComponent.path
            
            if sqlite3_open(filePath, &db) == SQLITE_OK
            {
                print("Successfuly opened the database :) \(filePath)")
                
                return db
            }
            else{
                print("Error opened the database")
            }
        }
        else
        {
            print("File Path is not available.")
        }
        return db
    }
    
    func  createTables() -> Bool {
        var bRetVal : Bool = false
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXIST ticket ( id INTEGER PRIMARY KEY AUTO_INCREMENT, categoria TEXT, problema TEXT, area TEXT, empleado TEXT)", nil, nil, nil)
        if (createTable != SQLITE_OK) {
            print("not able to crete table")
            bRetVal = false
        }
        else
        {
            bRetVal=true
        }
        return bRetVal
    }

}

