//
//  String+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/5.
//

import Foundation

extension String {
    static func randomString(length: Int) -> Self? {
        guard length > 0 else { return nil }
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var result = ""
        for _ in 0..<length {
            result.append(allowedChars.randomElement()!)
        }
        return result
    }
    
    /// 將格式為「yyyy-MM-dd'T'HH:mm:ssZ」轉成對應的Date資訊
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
    
    /// 將String轉換成URL
    func toURL() -> URL? { URL(string: self) }
}
