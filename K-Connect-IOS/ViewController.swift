//
//  ViewController.swift
//  Study7
//
//  Created by 이준협 on 2022/01/26.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import JWTDecode

class ViewController: UIViewController {
    
    var imgLogo : UIImage?
    var data : Array<Dictionary<String, Any>>?
    
    @IBOutlet var userIdInput: UITextField!
    @IBOutlet var userPwdInput: UITextField!
    @IBOutlet var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
        print("ViewController")
    }
    @IBAction func LoginBtn(_ sender: Any) {
        UserDefaults.resetStandardUserDefaults()
        LoadingService.showLoading()
      login()
        
    }
    
    func login(){
        
        let userId = userIdInput.text!
        let userPwd = userPwdInput.text!
        
//        if userId == ""{
//            let alert = UIAlertController(title: "알림", message: "이메일을 입력하세요.", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
//            }
//            alert.addAction(ok)
//            self.present(alert, animated: true, completion: nil)
//            return
//        }else if userPwd == ""{
//            let alert = UIAlertController(title: "알림", message: "비밀번호를 입력하세요.", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
//            }
//            alert.addAction(ok)
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
                let url = "https://kconnect.ksmartech.com:8443/login"
                var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.timeoutInterval = 10
                
                //let params = ["email" : "\(userId)","password" : "\(userPwd)"] as Dictionary
        
                let params = ["email" : "leejh0815@ksmartech.com","password" : "dlwnsguq0815!"] as Dictionary
                
                do{
                    try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                    
                }catch{
                    print("http Body Error")
                }
               
                AF.request(request).responseString{ (response) in
                    switch response.result{
                    case .success(let resData):
                        print("ViewController resData: \(resData) ")
                        let decoder = JSONDecoder()
                        let data = resData.data(using: .utf8)
 
                        if let data = data,let loginModel = try? decoder.decode(LoginModel.self, from:data){
                            
                            let loginToken = loginModel.data.token
                            let TOKEN = loginModel.data.token
                            let jwt = try? decode(jwt: TOKEN)
                            
                            let saveSuccessToken: Bool = KeychainWrapper.standard.set(loginToken, forKey:"token" )
                            if saveSuccessToken{
                                print("토큰 저장 완료")
                            }else{
                                print("토큰 저장 실패")
                            }
                            
                            
                            if let TOKEN = jwt {
                                let INF = infotmation(nbf: TOKEN.body["nbf"] as! Int, REQUIRE_PASSWORD_CHANGE: TOKEN.body["REQUIRE_PASSWORD_CHANGE"] as! Bool, TEAM_POSITION: TOKEN.body["TEAM_POSITION"] as! String, iat: TOKEN.body["iat"] as! Int, USER_ID: TOKEN.body["USER_ID"] as! Int, EMAIL: TOKEN.body["EMAIL"] as! String, NAME: TOKEN.body["NAME"] as! String, exp: TOKEN.body["exp"] as! Int, ROLE: TOKEN.body["ROLE"] as! String)
                                
                                
                                UserDefaults.standard.set(INF.nbf, forKey: "nbf")
                                UserDefaults.standard.set(INF.REQUIRE_PASSWORD_CHANGE, forKey: "REQUIRE_PASSWORD_CHANGE")
                                UserDefaults.standard.set(INF.TEAM_POSITION, forKey: "TEAM_POSITION")
                                UserDefaults.standard.set(INF.iat, forKey: "iat")
                                UserDefaults.standard.set(INF.USER_ID, forKey: "USER_ID")
                                UserDefaults.standard.set(INF.EMAIL, forKey: "EMAIL")
                                UserDefaults.standard.set(INF.NAME, forKey: "NAME")
                                UserDefaults.standard.set(INF.exp, forKey: "exp")
                                UserDefaults.standard.set(INF.ROLE, forKey: "ROLE")
                                
                                
                                
                                if INF.REQUIRE_PASSWORD_CHANGE == true {
                                    let viewControllerName = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordView")
                                        viewControllerName?.modalTransitionStyle = .flipHorizontal
                                    if let view = viewControllerName {
                                        view.modalTransitionStyle = .coverVertical
                                        let transition = CATransition()
                                                transition.duration = 0.5
                                                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                                                transition.type = CATransitionType.push
                                                transition.subtype = CATransitionSubtype.fromRight
                                                self.view.window!.layer.add(transition, forKey: nil)
                                        self.present(view, animated: false, completion: nil)
                                        }
                                }else{
                                    // 비밀번호변경페이지가 아니면 사용자 메인으로 이동
                                    print("메인페이지로 이동해야함")
                                    LoadingService.hideLoading()
                                    
                                    let storyboard = UIStoryboard(name: "EmployeeStoryboard", bundle: nil)
                                    
                                    let settingBoard = storyboard.instantiateViewController(withIdentifier: "EmployeeMainPage")
                                    settingBoard.modalPresentationStyle = .fullScreen  // 이거 없으면 팝업.
                                    let transition = CATransition()
                                            transition.duration = 0.5
                                            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                                            transition.type = CATransitionType.push
                                            transition.subtype = CATransitionSubtype.fromRight
                                            self.view.window!.layer.add(transition, forKey: nil)
                                    //self.present(settingBoard, animated: false, completion: nil)
                                    self.navigationController?.pushViewController(settingBoard, animated: true)
                                  
                                }
                            }
                            
                        }else{
                            print("decode error")
                            let alert = UIAlertController(title: "알림", message: "아이디와 비밀번호를 확인하십시오.", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                            }
                            alert.addAction(ok)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
    }
}

class APIManager: NSObject{
    internal static func getAPIHeader() -> HTTPHeaders {
        var header = HTTPHeaders()
        let token: String? = KeychainWrapper.standard.string(forKey: "token")
        let authorization: String! = token
        
        header.add(name: "Authorization", value: "Bearer "+authorization!)

        return header
    }
}
