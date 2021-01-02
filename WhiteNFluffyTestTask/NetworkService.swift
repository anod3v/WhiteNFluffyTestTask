//
//  NetworkService.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkService {
    
    let baseHost: String = "api.weather.yandex.ru"
    var version: String { return "2" }
    var keyHeader: String = "X-Yandex-API-Key"
    let configuration = URLSessionConfiguration.default
    
    func makeRequest<Output: Codable>(method: String, queryItems: [URLQueryItem] = []) -> Promise<Output> {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = self.baseHost
        urlConstructor.path = "/v\(version)/\(method)"
        
        urlConstructor.queryItems = [
        ]
        
        urlConstructor.queryItems?.append(contentsOf: queryItems)
        
        var request = URLRequest(url: urlConstructor.url!)
        request.allHTTPHeaderFields = [keyHeader: ApiManager.session.accessKey]
        let session = URLSession(configuration: configuration)
        
        return Promise { seal in
            let task = session.dataTask(with: request) { (data, response, apiError) in
                
                if let error = apiError {
                    seal.reject(error)
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(Output.self, from: data!)
                    seal.fulfill(response)
                } catch let decodingError {
//                    ApiManager.session.eraseAll()
                    debugPrint(decodingError)
                    seal.reject(decodingError)
                }
            }
            task.resume()
        }
    }
}

