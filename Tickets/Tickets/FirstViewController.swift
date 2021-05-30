//
//  FirstViewController.swift
//  Tickets
//
//  Created by user182859 on 5/30/21.
//  Copyright © 2021 user182859. All rights reserved.
//

import UIKit
import SQLite3

class FirstViewController: UIViewController {
@IBOutlet weak var viewTickets: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectStatementString = "SELECT catergoria,problema,area,empleado FROM ticket"
        var selectStatementQuery:OpaquePointer?
        
        var sShowData :String!
        sShowData = ""
        if sqlite3_prepare_v2(dbQueue, selectStatementString, -1, &selectStatementQuery, nil) == SQLITE_OK
        {
            while sqlite3_step(selectStatementQuery)==SQLITE_ROW {
                sShowData += String(cString: sqlite3_column_text(selectStatementQuery, 0)) + "\t\t" + String(cString: sqlite3_column_text(selectStatementQuery, 1)) + "\t\t" + String(cString: sqlite3_column_text(selectStatementQuery, 2)) + "\t\t" + String(cString: sqlite3_column_text(selectStatementQuery, 3)) + "\n"
            }
            sqlite3_finalize(selectStatementQuery)
        }
        viewTickets.text = sShowData ?? ""
        // Do any additional setup after loading the view.
    }

    
    
}

