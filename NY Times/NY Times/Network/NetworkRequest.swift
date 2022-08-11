//
//  NetworkRequest.swift
//  NY Times
//
//  Created by Mohamed Zaki on 11/08/2022.
//

import Foundation
import Moya

class NetworkHandler {
    func request<T: Codable>(type: T.Type, completion: ((T) -> Void)?) {
        let provider = MoyaProvider<Services>()
        provider.request(.mostPopularNews) { result in
            switch result {
            case let .success(response):
                do {
                    let model = try JSONDecoder().decode(T.self, from: response.data)
                    completion?(model)
                }
                catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
