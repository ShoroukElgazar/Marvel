//
//  MoyaProvider+Create.swift
//  Marvel
//
//  Created by Mac on 16/06/2023.
//

import Foundation
import Moya
import Alamofire

extension MoyaProvider {
    
    static func create<Target: TargetType>() -> MoyaProvider<Target> {
        var config = NetworkLoggerPlugin.Configuration()
        
        config.logOptions = NetworkLoggerPlugin.Configuration.LogOptions.verbose
        
        let logger = NetworkLoggerPlugin(configuration: config)
        
        return MoyaProvider<Target>(plugins: [logger])
    }
    

}
