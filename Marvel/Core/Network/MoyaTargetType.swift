//
//  MoyaTargetType.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation
import Moya

protocol MoyaTargetType: TargetType {
}

extension MoyaTargetType {
    public var baseURL: URL {
        URL(string: "https://gateway.marvel.com/v1/public/")!
    }

    public var validationType: ValidationType {
        .none
    }

    public var sampleData: Data {
        Data()
    }

    public var headers: [String: String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    var parameters: [String: Any]? {
        ["ts":"1",
        "apikey":"88a25849ee92a0f523dae79a4dc36876",
        "hash":"0337fb3777a2a352e5ec44cf4988166e"
        ]
    }


}
