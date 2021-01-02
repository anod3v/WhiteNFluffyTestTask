//
//  ApiManager.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class ApiManager {
    static let session = ApiManager()
    
    var accessKey: String {
        get {
            KeychainWrapper.standard.string(forKey: "vk-api-key") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "vk-api-key")
        }
    }
    
    func eraseAll() {
        KeychainWrapper.standard.removeAllKeys()
    }
    
    private init() {}
    
}
