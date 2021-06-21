//
//  ApiRouter.swift
//  PokemonPocket
//
//  Created by Pooh on 21/6/2564 BE.
//

import Alamofire
import CodableAlamofire
import Foundation

enum APIRouter: URLRequestConvertible {
    case pokemonList
    
    // MARK: - HTTPMethod
    //https://pokeapi.co/api/v2/pokemon?limit=99&offset=0
    
    private var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .pokemonList:
            return "pokemon"
        }
    }
    
    private var baseURL: String {
        switch self {
        default:
            return "https://pokeapi.co/api/v2/"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .pokemonList:
            return ["limit": "99", "offset": "0"]
        }
    }
    
    // MARK: Internal
    
    // MARK: - URLRequestimageURLible
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        
        if let parameters = parameters {
            let addedQueryStringURL = URL(string: url.appendingQueryItems(parameters))
            urlRequest = URLRequest(url: addedQueryStringURL!.appendingPathComponent(self.path))
        } else {
            urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        }
        
        // HTTP Method
        urlRequest.httpMethod = self.method.rawValue
        
        if self.method.rawValue == "GET" {
            // Common Headers
            urlRequest.setValue("996806944052152", forHTTPHeaderField: "App-Id")
            
            // Parameters
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
            
            
        }
        return urlRequest
    }
}




extension URL {
    func appendingQueryItems(_ contentsOf: [String: Any?]) -> String {
        guard var urlComponents = URLComponents(string: absoluteString), !contentsOf.isEmpty else {
            return absoluteString
        }
        
        let keys = contentsOf.keys.map { $0.lowercased() }
        
        urlComponents.queryItems = urlComponents.queryItems?
            .filter { !keys.contains($0.name.lowercased()) } ?? []
        
        urlComponents.queryItems?.append(contentsOf: contentsOf.compactMap {
            guard let value = $0.value else { return nil } // Skip if nil
            return URLQueryItem(name: $0.key, value: "(value)")
        })
        
        return urlComponents.string ?? absoluteString
    }
    
    func getKeyVals() -> [String: String]? {
        var results = [String: String]()
        if self.query != nil {
            let keyValues = self.query?.components(separatedBy: "&")
            if (keyValues?.count)! > 0 {
                for pair in keyValues! {
                    let kv = pair.components(separatedBy: "=")
                    if kv.count > 1 {
                        results.updateValue(kv[1], forKey: kv[0])
                    }
                }
            }
        }
        return results
    }
}

