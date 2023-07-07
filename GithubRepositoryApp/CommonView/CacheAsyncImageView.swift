//
//  CacheAsyncImageView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/7.
//

import SwiftUI

struct CacheAsyncImageView: View {
    
    @State var phase: AsyncImagePhase
    let urlRequest: URLRequest
    let session: URLSession
    @State var errorType: URLSession.FetchImageError = .other(describe: "None")
    
    init(url: URL, session: URLSession = .imageSession) {
        self.session = session
        self.urlRequest = URLRequest(url: url)
        if let data = session.configuration.urlCache?.cachedResponse(for: urlRequest)?.data,
           let uiImage = UIImage(data: data) {
            _phase = .init(initialValue: .success(.init(uiImage: uiImage)))
        } else {
            _phase = .init(initialValue: .empty)
        }
    }
    
    var body: some View {
        Group {
            switch phase {
                case .empty:
                    ProgressView()
                        .onAppear { load() }
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure(_):
                    Text(errorType.rawValue)
                @unknown default:
                    fatalError()
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func load() {
        Task {
            do {
                let uiImage = try await session.uiImage(request: urlRequest)
                phase = .success(.init(uiImage: uiImage))
            } catch {
                guard let errorTransfer = error as? URLSession.FetchImageError else {
                    errorType = .other(describe: "錯誤")
                    phase = .failure(error)
                    return
                }
                errorType = errorTransfer
                phase = .failure(error)
            }
        }
    }
}
