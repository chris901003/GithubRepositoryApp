//
//  URLSession+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/7.
//

import Foundation
import SwiftUI

extension URLSession {
    static let imageSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .imageCache
        return .init(configuration: config)
    }()
    
    static let repoSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .repoInfoCache
        return .init(configuration: config)
    }()
    
    static let userSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .userInfoCache
        return .init(configuration: config)
    }()
}

extension URLSession {
    func uiImage(request: URLRequest) async throws -> UIImage {
        let (data, response) = try await self.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw FetchImageError.statusCodeTransfer }
        guard 200...299 ~= response.statusCode else { throw FetchImageError.statusCode(code: response.statusCode) }
        guard let uiImage = UIImage(data: data) else { throw FetchImageError.imageTransfer }
        return uiImage
    }
    
    enum FetchImageError: RawRepresentable, LocalizedError {
        
        var rawValue: String {
            switch self {
                case .internet:
                    return "網路連線失敗"
                case .statusCodeTransfer:
                    return "狀態碼轉換失敗"
                case .statusCode(code: let code):
                    return "狀態碼異常: \(code)"
                case .imageTransfer:
                    return "無法轉換成圖像資料"
                case .other(describe: let describe):
                    return "錯誤: \(describe)"
            }
        }
        
        init?(rawValue: String) {
            switch rawValue {
                case "internet":
                    self = .internet
                case "statusCodeTransfer":
                    self = .statusCodeTransfer
                case "statusCode":
                    // RawValue的啟動方式不可以自行帶入其他資料，所以這裡我直接使用默認的404
                    self = .statusCode(code: 404)
                case "imageTransfer":
                    self = .imageTransfer
                default:
                    self = .other(describe: rawValue)
            }
        }
        
        case internet
        case statusCodeTransfer
        case statusCode(code: Int)
        case imageTransfer
        case other(describe: String)
    }
}
