//
//  NetworkRequest.swift
//  NY Times
//
//  Created by Mohamed Zaki on 11/08/2022.
//

import Foundation
import Moya

class NetworkRequest: NetworkRequestProtocol {
    func request<T: Codable>(type: T.Type, completion: ((Result<T, Error>) -> Void)?) {
        let provider = MoyaProvider<Services>()
        provider.request(.mostPopularNews) { result in
            switch result {
            case let .success(response):
                do {
                    let model = try JSONDecoder().decode(T.self, from: response.data)
                    completion?(.success(model))
                }
                catch {
                    completion?(.failure(error))
                }
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
}
