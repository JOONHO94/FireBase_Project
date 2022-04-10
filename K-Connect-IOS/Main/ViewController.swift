//
//  ViewController.swift
//  Study7
//
//  Created by 최준호 on 2022/01/26.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import JWTDecode
import Firebase
import FirebaseAuth
import Lottie

//pod 'Firebase/Auth' 유저 관련 pod
//pod 'Firebase/Database' Realtime Database 관련 pod

class ViewController: UIViewController {
    let UIImage1 = UIImage(named: "BackGround.jpeg")
    
    var data : Array<Dictionary<String, Any>>?
    @IBOutlet var userIdInput: UITextField!
    @IBOutlet var userPwdInput: UITextField!

    @IBOutlet weak var Btn_Login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//            backgroundImage.image = UIImage(named: "BackGround.jpeg")
//            //backgroundImage.contentMode = UIViewContentMode.scaleAspectfill
//            self.view.insertSubview(backgroundImage, at: 0)
    
        overrideUserInterfaceStyle = .light
        
        if let user = Auth.auth().currentUser {
            userPwdInput.placeholder = "이미 로그인 된 상태입니다."
            //fireBase에서 로그인 계속 유지하도록 설정
            
        }

        print("-----ViewController-----")
    }
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        guard let email = userIdInput.text, let password = userPwdInput.text
        else{return}
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (authResult, error) in
            guard let user = authResult?.user else { return }
            
            if error == nil {
                print("------login success----")
                print("Test Login Btn : \(user)")
            } else if error != nil {
                print("---------------------------error")
                print("login fail")
            }
        }
        
    }
    
    @IBAction func Btn_GoJoin(_ sender: Any) {
        Logout()
        
        
        if let Controller = self.storyboard?.instantiateViewController(withIdentifier: "JoinController") {
            self.navigationController?
                .pushViewController(Controller,animated: true)
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
