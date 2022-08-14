//
//  NetworkRequestProtocol.swift
//  NY Times
//
//  Created by Mohamed Zaki on 14/08/2022.
//

import Foundation

protocol NetworkRequestProtocol {
    func request<T: Codable>(type: T.Type, completion: ((Result<T, Error>) -> Void)?)
}
