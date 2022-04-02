//
//  LoginModel.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/16.
//


//로그인 토큰 값 모델
import Foundation

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
