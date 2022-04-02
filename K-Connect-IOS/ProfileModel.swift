//
//  ProfileModel.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/18.
//


// 사용자 메인화면 사용자 정보 저장하는 모델
import Foundation

struct ProfileModel: Codable {
    let success: Bool
    let data: DataClassProfile
}

struct DataClassProfile: Codable {
    let userID: Int
    let userName, phoneNumber, year: String
    let totalDays: Int
    let usedDays, remainDays: Double
    let group: [Group]

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName, phoneNumber, year, totalDays, usedDays, remainDays, group
    }
}
struct Group: Codable {
    let groupID: Int
    let groupName, roleCD: String

    enum CodingKeys: String, CodingKey {
        case groupID = "groupId"
        case groupName
        case roleCD = "roleCd"
    }
}
