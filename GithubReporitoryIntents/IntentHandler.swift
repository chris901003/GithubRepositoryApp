//
//  IntentHandler.swift
//  GithubReporitoryIntents
//
//  Created by 黃弘諺 on 2023/7/11.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
}

// MARK: SingleRepoWidget Intents Selections
extension IntentHandler: SingleRepoSelectIntentHandling {
    func provideRepositoryOptionsCollection(for intent: SingleRepoSelectIntent) async throws -> INObjectCollection<NSString> {
        do {
            let repoInfo: [RepositoryModel] = try UserDefaultManager.shared.fetchDataCodable(key: .repoList)
            let repoLinks = repoInfo.map { $0.repoLink }
            return INObjectCollection(items: repoLinks as [NSString])
        } catch {
            return INObjectCollection(items: ["Placeholder"] as [NSString])
        }
    }
    
    func defaultRepository(for intent: SingleRepoSelectIntent) -> String? {
        return "Placeholder"
    }
}

// MARK: SingleUserWidget Intents Selections
extension IntentHandler: SingleUserSelectIntentHandling {
    func provideUserOptionsCollection(for intent: SingleUserSelectIntent) async throws -> INObjectCollection<NSString> {
        do {
            let userInfo: [UserFollowModel] = try UserDefaultManager.shared.fetchDataCodable(key: .userList)
            let userNames = userInfo.map { $0.user }
            return INObjectCollection(items: userNames as [NSString])
        } catch {
            return INObjectCollection(items: ["Placeholder"] as [NSString])
        }
    }
    
    func defaultUser(for intent: SingleUserSelectIntent) -> String? {
        return "Placeholder"
    }
}
