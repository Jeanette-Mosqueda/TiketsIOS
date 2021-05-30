//
//  SecondViewController.swift
//  Tickets
//
//  Created by user182859 on 5/30/21.
//  Copyright © 2021 user182859. All rights reserved.
//

import UIKit
import SQLite3

class SecondViewController: UIViewController {
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    @IBOutlet weak var textFiledProblema: UITextField!
    @IBOutlet weak var textFiledCategoria: UITextField!
    
    
    @IBOutlet weak var textFiledArea: UITextField!
    
    @IBOutlet weak var textFiledEmpleado: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addData(_ sender: Any) {
        let insertStatementSring = "INSET INTO ticket (catergoria,problema,area,empleado) VALUES (?, ?, ?, ?);"
        var insertStatementQuery : OpaquePointer?
        
        if(sqlite3_prepare_v2(dbQueue, insertStatementSring, -1, &insertStatementQuery, nil)) == SQLITE_OK
        {
            sqlite3_bind_text(dbQueue, 1, textFiledCategoria.text ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(dbQueue, 2, textFiledProblema.text ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(dbQueue, 3, textFiledArea.text ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(dbQueue, 4, textFiledEmpleado.text ?? "", -1, SQLITE_TRANSIENT)
            if(sqlite3_step(insertStatementQuery)) == SQLITE_DONE
            {
                textFiledCategoria.text=""
                textFiledProblema.text=""
                textFiledArea.text=""
                textFiledEmpleado.text=""
                
                textFiledCategoria.becomeFirstResponder()
                print("Sucessfully inserted the record")
            }
            else{
                print("Error")
            }
            sqlite3_finalize(insertStatementQuery)
        }
        
    }
    
}

