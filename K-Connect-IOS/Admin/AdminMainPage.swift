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
    @IBAction func Test(_ sender: Any) {
        print("sssssssssssssssssssss")
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
    
    
    
    func TotalCount(){
        let url = "https://kconnect.ksmartech.com:8443/admin/totalCount"
        let header = APIManager.getAPIHeader()
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header)//["Content-Type":"application/json", "Accept":"application/json"]   //
                    .validate(statusCode: 200..<300)
                    .responseJSON { (json) in
                        //여기서 가져온 데이터를 자유롭게 활용하세요.
                        print("Test", json)
                    }
        
    }
    
    
    
}
