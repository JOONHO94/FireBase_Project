//
//  LoginModel.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/16.
//


//로그인 토큰 값 모델
import Foundation
import FirebaseAuth
//firebase 로그인 함수
func Login(_ email: String, _ password: String) {
    Auth.auth().signIn(withEmail: email, password: password) {
        (authResult, error) in
        guard let user = authResult?.user else { return }
        
        if error == nil {
            print("------login success----")
            print("Test Login Btn : \(user)")
        } else {
            print("---------------------------error")
            print("login fail")
        }
    }
    
}

func Logout() {
    
}

// MARK: - Welcome
struct LoginModel: Codable {
    let success: Bool
    let data: DataClass
}

struct DataClass: Codable {
    let dataInit: Bool
    let token: String

    enum CodingKeys: String, CodingKey {
        case dataInit = "init"
        case token
    }
}
