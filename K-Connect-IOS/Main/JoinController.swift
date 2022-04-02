//
//  JoinController.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/04/02.
//

import UIKit
import Firebase
import FirebaseAuth
//Realtime Database


class JoinController: UIViewController {
    
    @IBOutlet weak var TextField_Email: UITextField!
    @IBOutlet weak var TextField_Pw: UITextField!
    @IBOutlet weak var TextField_PwCheck: UITextField!
    
    //var ref: FIRDatabaseReference!
    lazy var rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func Btn_DoJoin(_ sender: Any) {
        guard let email = TextField_Email.text, let password = TextField_Pw.text else{return}
        Auth.auth().createUser(withEmail: email, password: password) {
            (authResult, error) in
            if error ==  nil {
                print("-----register success-----")
                
            }
            else {
                print("error 회원가입 실패 register failed")
                
            }
            
        }
        
    }
    
    
    @IBAction func Btn_BackNavigation(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
}
