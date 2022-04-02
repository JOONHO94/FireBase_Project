//
//  AdminDetailPage.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/03/07.
//

import UIKit

class AdminDetailPage : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func Btn_GoVacationHistory(_ sender: Any) {
        print("Test Button")
        if let Controller = self.storyboard?
            .instantiateViewController(withIdentifier: "AdminVacationHistoryPage") {
            self.navigationController?
                .pushViewController(Controller,animated: true)
        }
    }
}
