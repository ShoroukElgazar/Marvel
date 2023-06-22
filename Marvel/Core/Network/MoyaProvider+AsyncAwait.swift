//
//  MoyaProvider+AsyncAwait.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation
import Moya
import Alamofire

extension MoyaProvider {

    func request<T: Decodable>(
            target: Target
    ) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            if NetworkReachabilityManager()?.isReachable ?? false {
                request(target) {
                    switch $0 {
                    case let .success(response):
                        do {
                            let filteredResponse = try response.filterSuccessfulStatusCodes()
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(T.self, from: filteredResponse.data)
                            continuation.resume(returning: result)
                        } catch {
                            let error = error
                            print("Request Error: \(error)")
                            continuation.resume(throwing: AppError.decoding)
                        }
                    case let .failure(error):
                        print("Request Error: \(error)")
                        continuation.resume(throwing: AppError.unknown)
                    }
                }
            }else {
                continuation.resume(throwing: AppError.offline)
            }
        }
    }
    

}

