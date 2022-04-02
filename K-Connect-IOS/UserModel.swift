//
//  UserModel.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/16.
//

//로그인 성공시 사용자 정보 저장하는 모델

import Foundation
struct infotmation {
    var nbf: Int
    var REQUIRE_PASSWORD_CHANGE: Bool
    var TEAM_POSITION: String
    var iat: Int
    var USER_ID: Int
    var EMAIL: String
    var NAME: String
    var exp: Int
    var ROLE: String

    init(nbf: Int, REQUIRE_PASSWORD_CHANGE: Bool, TEAM_POSITION: String, iat: Int, USER_ID:Int, EMAIL: String, NAME: String, exp: Int, ROLE: String) {
        self.nbf = nbf
        self.REQUIRE_PASSWORD_CHANGE = REQUIRE_PASSWORD_CHANGE
        self.TEAM_POSITION = TEAM_POSITION
        self.iat = iat
        self.USER_ID = USER_ID
        self.EMAIL = EMAIL
        self.NAME = NAME
        self.exp = exp
        self.ROLE = ROLE
     }
    
}
