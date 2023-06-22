//
//  ComicsAPI.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation
import Moya


typealias ComicsAPIProvider = MoyaProvider<ComicsAPI>

enum ComicsAPI {
    case comics(page: Int)
    case comicsDetails(id: Int)
}

extension ComicsAPI: MoyaTargetType {

    var path: String {
        switch self {
        case .comics: return "comics"
        case let .comicsDetails(id): return "comics/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .comics, .comicsDetails: return .get
        }
    }

    var task: Task {
        switch self {
        case .comics,.comicsDetails:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    //TODO: CHANGE APIKEY make it const and apply it in all api
    var parameters: [String: Any] {
        switch self {
        case let .comics(limit):
             return ["ts":"1",
             "apikey":"88a25849ee92a0f523dae79a4dc36876",
             "hash":"0337fb3777a2a352e5ec44cf4988166e",
             "limit": limit
             ]
        case .comicsDetails:
            return ["ts":"1",
            "apikey":"88a25849ee92a0f523dae79a4dc36876",
            "hash":"0337fb3777a2a352e5ec44cf4988166e"
            ]
        }
    }

}

