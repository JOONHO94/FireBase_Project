//
//  ApprovalModel.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/22.
//


//결재리스트 저장하는 모델
import Foundation
// MARK: - Welcome
struct ApprovalModel: Codable {
    let success: Bool
    let data: ContentClass
}

// MARK: - DataClass
struct ContentClass: Codable {
    let content: [ContentData]
}

// MARK: - Content
struct ContentData: Codable {
    let vacationID, userID: Int
    let userName, vacationType, startDate, endDate: String
    let days: Int
    let comment, createDt: String

    enum CodingKeys: String, CodingKey {
        case vacationID = "vacationId"
        case userID = "userId"
        case userName, vacationType, startDate, endDate, days, comment, createDt
    }
}
