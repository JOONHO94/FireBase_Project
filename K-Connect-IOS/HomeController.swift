//
//  MainController.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/04/08.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func GoAdmin_Btn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AdminStoryboard", bundle: nil)
        
        let settingBoard = storyboard.instantiateViewController(withIdentifier: "AdminNavigation")
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
