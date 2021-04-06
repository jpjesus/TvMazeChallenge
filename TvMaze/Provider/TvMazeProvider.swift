//
//  TvMazeProvider.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import Moya

let apiKey = "46iP0wIKEbq7-FLONIHucOmNeWeb_sJC"
let apiUrl = "http://api.tvmaze.com"

enum TVMazeProvider {
    case getTvShows(page: Int)
}

extension TVMazeProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: apiUrl) ?? URL(fileURLWithPath: "")
    }
    
    var path: String {
        switch self {
        case .getTvShows:
            return "shows"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTvShows:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getTvShows:
            guard let url = Bundle.main.url(forResource: "tvMazeData", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case .getTvShows(let page):
            var params: [String: Any] = [:]
            params ["page"] = page
            params["api_key"] = apiKey
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
