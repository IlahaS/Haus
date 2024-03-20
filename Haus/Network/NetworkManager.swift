//
//  NetworkManager.swift
//  Haus
//
//  Created by Ilahe Samedova on 15.03.24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<T: Codable>(
        type: T.Type,
        endpoint: String,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        completion: @escaping((T?, String?) -> Void))
     {
        
        AF.request("\(NetworkHelper.baseURL)\(endpoint)").responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let items):
                completion(items, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
