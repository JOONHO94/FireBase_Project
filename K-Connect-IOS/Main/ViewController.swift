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
import TransitionButton

//pod 'Firebase/Auth' 유저 관련 pod
//pod 'Firebase/Database' Realtime Database 관련 pod

class ViewController: UIViewController {
    var patternImage : UIImage?
    
    @IBOutlet var userIdInput: UITextField!
    @IBOutlet var userPwdInput: UITextField!

    @IBOutlet weak var Btn_Login: TransitionButton!
    
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
//        Auth.auth().addStateDidChangeListener{(auth, user) in
//            if(user != nil) {
//                let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
//                vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
//                vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
//                self.present(vcName!, animated: true, completion: nil)
//                
//            }
//            
//        }
    }
    
    @IBAction func GoChangeBtn(_ sender: Any) {
     
    }
    
//    @IBAction func buttonAction(_ button: TransitionButton) {
//            button.startAnimation() // 2: Then start the animation when the user tap the button
//            let qualityOfServiceClass = DispatchQoS.QoSClass.background
//            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
//            backgroundQueue.async(execute: {
//
//                sleep(3) // 3: Do your networking task or background work here.
//
//                DispatchQueue.main.async(execute: { () -> Void in
//                    // 4: Stop the animation, here you have three options for the `animationStyle` property:
//                    // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
//                    // .shake: when you want to reflect to the user that the task did not complete successfly
//                    // .normal
//                    button.stopAnimation(animationStyle: .expand, completion: {
//                        let secondVC = UIViewController()
//                        self.present(secondVC, animated: true, completion: nil)
//                    })
//                })
//            })
//        }
//    }
    
    @IBAction func LoginBtn(_ button: TransitionButton) {
        print("Login 시도")
        Btn_Login.startAnimation() // 2: Then start the animation when the user tap the button
        guard let email = userIdInput.text, let password = userPwdInput.text
        else{return}
        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                sleep(0) // 3: Do your networking task or background work here.
                Auth.auth().signIn(withEmail: email, password: password) {( user, error) in
                    if error == nil {
                        button.stopAnimation(animationStyle: .expand, completion: {
                            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
                            secondVC?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                            self.present(secondVC!, animated: true, completion: nil)
                            
                        })
                        print("------login success-----")
                        print("-----UserInformation: \(user)-----")
                        
                    }
                    else if(error != nil) {
                        //error.debugDescription
                        let alert = UIAlertController(title: "알림", message: "아이디 혹은 비밀번호가 잘못 입력 되었습니다", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        button.stopAnimation(animationStyle: .shake, completion: {
                        })
                    }
                   self.Btn_Login.layer.cornerRadius = 13   //흔들고 나면 버튼 곡선이 해제되서 추가
                }
                DispatchQueue.main.async(execute: { () -> Void in
                })
            })
        Btn_Login.layer.cornerRadius = 13   //흔들고 나면 버튼 곡선이 해제되서 추가
        
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
   
    override func prepareForInterfaceBuilder() {
           super.prepareForInterfaceBuilder()
        Btn_Login.layer.cornerRadius = 13   //버튼 곡선화
       }
    @IBAction func GoMain_Test(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
        self.present(vcName!, animated: true, completion: nil)
    }
    
}
