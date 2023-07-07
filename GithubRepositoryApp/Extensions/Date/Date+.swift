//
//  Date+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/7.
//

import Foundation

extension Date {
    /// 獲取兩個時間間隔日
    static func countDayPass(from startDate: Date, to endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day ?? 0
    }
}
