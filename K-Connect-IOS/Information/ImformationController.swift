//
//  ImformationController.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/04/09.
//

import Foundation
import UIKit
import FirebaseAuth

class ImformationController: UIViewController {
    
    
    @IBOutlet weak var Label_UserName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-----ImformationStoryboard-----")
        if let user = Auth.auth().currentUser {
            Label_UserName.text = "이미 로그인 된 상태입니다."

            
        }
        
    }
    @IBAction func Btn_Logout(_ sender: Any) {
        print("-----Logout(ImformationController)-----")
        Logout()
        
    }
}
