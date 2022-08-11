//
//  NetworkHandler.swift
//  NY Times
//
//  Created by Mohamed Zaki on 11/08/2022.
//

import Foundation
import Moya

struct RequestConfigurations {
    static let privateKeyID = "SIO7nKG225GUNXTOmKbG8OcVlX5V1YO7"
    static let baseURL = "http://api.nytimes.com"
    static let path = "/svc/mostpopular/v2/viewed/7.json"
}
enum Services {
    case mostPopularNews
}

extension Services: TargetType {
    var baseURL: URL {
        URL(string: RequestConfigurations.baseURL)!
    }

    var path: String {
        RequestConfigurations.path
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        .requestParameters(parameters: ["api-key":RequestConfigurations.privateKeyID], encoding: URLEncoding.queryString)
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
