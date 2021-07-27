//
//  MainTarget.swift
//  Nasa
//
//  Created by kairzhan on 7/27/21.
//

import Foundation

enum MainTarget: ApiTarget {
    case getPhotos(sol: String, page: String, api_key: String)
    
    var version: ApiVersion {
        return .custom("")
    }
    
    var servicePath: String {
        return ""
    }
    
    var path: String {
        return "mars-photos/api/v1/rovers/curiosity/photos"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .getPhotos(sol, page, api_key):
            return [
                "sol": sol,
                "page": page,
                "api_key": api_key
            ]
        }
    }
    
    var stubData: Any {
        return []
    }
    
    
}
