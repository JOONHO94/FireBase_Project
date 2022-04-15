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
        overrideUserInterfaceStyle = .light
        UINavigationBar.appearance().barTintColor = .white
        
        
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
    
    @IBAction func GoSearch_Btn(_ sender: Any) {
        print("GoSearch")
//        if let Controller = self.storyboard?.instantiateViewController(withIdentifier: "SearchController") {
//            self.navigationController?
//                .pushViewController(Controller,animated: true)
//        }
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "SearchController")
                vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                self.present(vcName!, animated: true, completion: nil)
    }
    
    @IBAction func GoNotification_Btn(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "NotificationController")
                vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                self.present(vcName!, animated: true, completion: nil)
    }
    
    
    
    
}
