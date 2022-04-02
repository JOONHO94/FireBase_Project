//
//  VacationListModel.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/03/02.
//

//팀 내 연차 현황에서 팀원 연차 갯수 모델
import Foundation

// MARK: - Welcome
struct VacationListModel: Codable {
    let success: Bool
    let data: ListClass
}

// MARK: - DataClass
struct ListClass: Codable {
    let content: [Content2]
    let pageable: Pageable2
}

// MARK: - Content
struct Content2: Codable {
    let userName, year: String
    let totalDays: Int
    let usedDays: Double
}

// MARK: - Pageable
struct Pageable2: Codable {
    let totalPages, totalElements, page: Int
}
