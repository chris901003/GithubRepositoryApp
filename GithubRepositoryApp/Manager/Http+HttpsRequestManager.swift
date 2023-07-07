//
//  Http+HttpsRequestManager.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/7.
//

import Foundation

class HttpRequestManager {
    
    // Singleton
    static let shared: HttpRequestManager = HttpRequestManager()
    
    // Private Init Function
    private init() { }
}

extension HttpRequestManager {
    
    /// 獲取資料並且轉換成指定型態
    func fetchData<T: Decodable>(urlRequest: URLRequest,
                                 dataType: T.Type,
                                 statusCodeRange: ClosedRange<Int> = 200...299,
                                 session: URLSession = .shared) async throws -> T {
        guard let (data, response) = try? await session.data(for: urlRequest) else { throw FetchDataError.internet }
        guard let response = response as? HTTPURLResponse,
              statusCodeRange ~= response.statusCode else { throw FetchDataError.statusCode }
        guard let result = try? JSONDecoder().decode(dataType, from: data) else { throw FetchDataError.decode }
        return result
    }
    
    /// 給fetchData使用的錯誤狀態
    enum FetchDataError: String, LocalizedError {
        case internet = "網路連線失敗"
        case statusCode = "狀態碼異常"
        case decode = "無法解析資料"
    }
}
