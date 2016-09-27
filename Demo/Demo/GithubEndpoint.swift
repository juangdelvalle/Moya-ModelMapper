//
//  GithubEndpoint.swift
//  Demo
//
//  Created by Lukasz Mroz on 08.02.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Foundation
import Moya

private extension NSString {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)!
    }
}

enum GitHub {
    case Zen
    case UserProfile(String)
    case Repos(String)
    case Repo(String)
}

extension GitHub: TargetType {
    public var task: Task {
        return .request
    }

    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .Repos(let name):
            return "/users/\(name.URLEscapedString)/repos"
        case .Zen:
            return "/zen"
        case .UserProfile(let name):
            return "/users/\(name.URLEscapedString)"
        case .Repo(let name):
            return "/repos/\(name)"
        }
    }
    var method: Moya.Method {
        return .GET
    }
    var parameters: [String : Any]? {
        return nil
    }
    var sampleData: Data {
        switch self {
        case .Repos(_):
            return "{{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\"}}".data(using: String.Encoding.utf8)!
        case .Zen:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .UserProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case .Repo(_):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: String.Encoding.utf8)!
        }
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
}
