//
//  VacationDateModel.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/03/02.
//

import Foundation

// MARK: - Welcome
//팀원 연차 현황 달력 데이터 모델
struct VacationDateModel: Codable {
    let success: Bool
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let userName: String
    let days, vacationType: [String]
}
