//
//  SearchController.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/04/15.
//

import Foundation
import UIKit

class SearchController: UIViewController {
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        
    }
    
    @IBAction func GoHome_Btn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)   //네비게이션으로 보내거나 그냥 보내면 탭바 네비게이션 다 사라짐
    }
    
    
    
}
