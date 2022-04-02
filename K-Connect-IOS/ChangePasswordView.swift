//
//  ChangePasswordView.swift
//  Kconnect
//
//  Created by 이준협 on 2022/01/27.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class ChangePasswordView : UIViewController{
    
   
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var newPasswordInput: UITextField!
    @IBOutlet var newPasswordCheckInput: UITextField!
    

    var imgLogo : UIImage?
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ChangePasswordView 실행")
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
    }
    
    @IBAction func changBtn(_ sender: Any) {
     passwordChange()
    }
    
    func passwordChange(){
        if passwordInput.text == ""{ //기존 비밀번호 입력안했을경우
            let alert = UIAlertController(title: "알림", message: "기존 비밀번호를 입력하세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                return
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }else if newPasswordInput.text == "" || newPasswordCheckInput.text == ""{ //신규 비밀번호, 신규비밀번호 확인 입력 안했을경우.
            let alert = UIAlertController(title: "알림", message: "신규 비밀번호를 입력하세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                return
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        if newPasswordInput.text != newPasswordCheckInput.text{
            //신규비밀번호, 신규비밀번호 확인 값이 다른경우.
            let alert = UIAlertController(title: "알림", message: "신규 비밀번호와 신규 비밀번호 확인 값이 다릅니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                return
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        let alert = UIAlertController(title: "알림", message: "비밀번호를 변경 하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
            
        }
        let cancel = UIAlertAction(title: "취소", style: .default){ (cancel) in
            return
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
        
        var pwd = passwordInput.text!
        var newPwd = newPasswordInput.text!
        
        
         let url = "https://kconnect.ksmartech.com:8443/init"
         var request = URLRequest(url: URL(string: url)!)
         request.httpMethod = "PUT"
         request.headers = APIManager.getAPIHeader()
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.timeoutInterval = 10
        
        
        let params = ["password" : "\(pwd)","newPassword" : "\(newPwd)"] as Dictionary
        do{
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            
        }catch{
            print("http Body Error")
        }
        
         AF.request(request).responseString{ (response) in
             switch response.result{
             case .success(let resData):
                 print("resData: ",resData)
             case .failure(let error):
                 print("에러에러에러",error)
             }
         }
    }
}
