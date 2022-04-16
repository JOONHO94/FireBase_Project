//
//  ssssss.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/02/16.
//

import UIKit
import Alamofire
import JWTDecode

class AdminMainPage: UIViewController {
    
    @IBOutlet weak var Lb_TotalMember: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func Btn_GoAdminEmployeeManage(_ sender: Any) {
        print("Test Button")
        if let Controller = self.storyboard?
            .instantiateViewController(withIdentifier: "AdminEmployeeManagePage") {
            self.navigationController?
                .pushViewController(Controller,animated: true)
        }
    }
    
    @IBAction func GoHomeBtn(_ sender: Any) {
        print("sssssssssssssssssssss")
    }
    
    
    
    
    
    @IBAction func GoHomeBt1n(_ sender: Any) {
        print("sssssssssssssssssssss")
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let settingBoard = storyboard.instantiateViewController(withIdentifier: "UserViewNavigation")
        settingBoard.modalPresentationStyle = .fullScreen  // 이거 없으면 팝업.
        let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                self.view.window!.layer.add(transition, forKey: nil)
        self.present(settingBoard, animated: false, completion: nil)
    }
    
    @IBAction func Btn_GoAdminGroupManage(_ sender: Any) {
        print("Test Button")
        if let Controller = self.storyboard?.instantiateViewController(withIdentifier: "AdminGroupManagePage") {
            self.navigationController?
                .pushViewController(Controller,animated: true)
        }
    }
    
    
    @IBAction func Btn_GoDayoff(_ sender: Any) {
        print("휴가 신청")
    }
    
    
    
    
    
    
    
    @IBAction func Btn_LogOut(_ sender: UIButton) {
        print("로그아웃 버튼 눌림")
//        let alert = UIAlertController(title: "알림", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
//            self.dismiss(animated: true, completion: nil)
//        }
//        let cancel = UIAlertAction(title: "취소", style: .cancel) { (cancle) in
//
//        }
//        alert.addAction(cancel)
//        alert.addAction(ok)
//        self.present(alert, animated: true, completion: nil)
    }
    
    
    
   
    
    
}
