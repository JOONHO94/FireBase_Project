//
//  ImformationSetController.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/04/16.
//

import UIKit

class ImformationSetController: UIViewController {
    override func viewDidLoad() {
        print("-----ImformationSetController-----")
    }
    
    @IBAction func Logout_Btn(_ sender: Any) {
        print("-----Logout-----")
        Logout()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let settingBoard = storyboard.instantiateViewController(withIdentifier: "MainNavigation")
        settingBoard.modalPresentationStyle = .fullScreen  // 이거 없으면 팝업.
        let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                self.view.window!.layer.add(transition, forKey: nil)
        self.present(settingBoard, animated: false, completion: nil)
    }
    
    
}
