//
//  TotalDaysModel.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/28.
//



//총 연차 일 수 확인하는 모델
import Foundation

// MARK: - Welcome
struct TotalDaysModel: Codable {
    let success: Bool
    let data: TotalDataClass
}

// MARK: - DataClass
struct TotalDataClass: Codable {
    let bizDays: Int
}
