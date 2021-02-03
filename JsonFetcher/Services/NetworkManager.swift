//
//  NetworkManager.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import Foundation
import Alamofire


protocol Networking {
    func fetchData(from url: String, completion: @escaping (Response?) -> ())
}

final class NetworkingManager: Networking {
    func fetchData(from url: String, completion: @escaping (Response?) -> ()) {
        AF.request(url)
            .validate()
            .responseDecodable(of: Response.self) { response in
                switch response.result {
                case .success(let response):
                    DispatchQueue.main.async {
                        completion(response)
                    }
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
    }
}
