//
//  ViewController.swift
//  Study7
//
//  Created by 최준호 on 2022/03/26.
//

import UIKit
import Firebase
import FirebaseAuth
import Lottie

//pod 'Firebase/Auth' 유저 관련 pod
//pod 'Firebase/Database' Realtime Database 관련 pod

class ViewController: UIViewController {
    var patternImage : UIImage?
    
    @IBOutlet var userIdInput: UITextField!
    @IBOutlet var userPwdInput: UITextField!

    @IBOutlet weak var Btn_Login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-----ViewController-----")
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround.jpeg")!)
        Btn_Login.layer.cornerRadius = 13   //버튼 곡선화
        overrideUserInterfaceStyle = .light
        
        if let user = Auth.auth().currentUser {
            userPwdInput.placeholder = "이미 로그인 된 상태입니다."
            //fireBase에서 로그인 계속 유지하도록 설정
        }
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if(user != nil) {
                let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
                vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                self.present(vcName!, animated: true, completion: nil)
                
            }
            
        }
    }
    
    @IBAction func GoChangeBtn(_ sender: Any) {
     
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        print("Login 시도")
        guard let email = userIdInput.text, let password = userPwdInput.text
        else{return}
        Auth.auth().signIn(withEmail: email, password: password) {( user, error) in
            
            if error == nil {
                print("------login success-----")
                print("-----UserInformation: \(user)-----")
            }
            else if(error != nil) {
                //error.debugDescription
                let alert = UIAlertController(title: "알림", message: "아이디 혹은 비밀번호가 잘못 입력 되었습니다", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
           
            
        }
        
    }
    
    @IBAction func Btn_GoJoin(_ sender: Any) {
        
        if let Controller = self.storyboard?.instantiateViewController(withIdentifier: "JoinController") {
            self.navigationController?
                .pushViewController(Controller,animated: true)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){   //touch시 키보드 내리는 함수
          self.view.endEditing(true)
    }
    @IBAction func GoMain_Test(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
        self.present(vcName!, animated: true, completion: nil)
    }
    
}
