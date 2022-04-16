//
//  LoginModel.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/03/16.
//


//로그인 토큰 값 모델
import Foundation
import FirebaseAuth


class LoadingService {
    static func showLoading() {
        DispatchQueue.main.async {
            // 아래 윈도우는 최상단 윈도우
            guard let window = UIApplication.shared.windows.last else { return }

            let loadingIndicatorView: UIActivityIndicatorView
            // 최상단에 이미 IndicatorView가 있는 경우 그대로 사용.
            if let existedView = window.subviews.first(
                where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else { // 새로 만들기.
                loadingIndicatorView = UIActivityIndicatorView(style: .large)
                // 아래는 다른 UI를 클릭하는 것 방지.
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.color = .brown

                window.addSubview(loadingIndicatorView)
            }
            loadingIndicatorView.startAnimating()
        }
    }
    static func hideLoading() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            window.subviews.filter({ $0 is UIActivityIndicatorView })
                .forEach { $0.removeFromSuperview() }
        }
    }
}

//firebase 로그인 함수
func Login(_ email: String, _ password: String) {
    Auth.auth().signIn(withEmail: email, password: password) {
        (authResult, error) in
        guard let user = authResult?.user else { return }
        
        if(error != nil) {
            print("-----login fail error-----")
            let alert = UIAlertController(title: "알림", message: "아이디와 비밀번호를 확인하십시오.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                LoadingService.hideLoading()
            }
            
        }
        else if error == nil {
            print("-----login success-----")
            print("-----Test Login Btn : \(user)-----")
//        } else {
//            print("-----login fail error-----")
//        }
    }
    
    
}
    
}

func Logout() {
    do {
        try Auth.auth().signOut()
    } catch let signOutError as NSError {
        print("-----Logout Error-----")
        
    }
    
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
