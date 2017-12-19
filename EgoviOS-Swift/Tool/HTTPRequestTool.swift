//
//  HTTPRequestTool.swift
//  RXSwiftDemo
//
//  Created by 新龙科技 on 2017/2/9.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import Moya

let URLString = "http://47.95.5.138:8888/app"

let HttpTool = MoyaProvider<HTTPTool>()
enum HTTPTool {
    case LogIn(Name:String,Psw:String)
    case getArticleDetailIndex(page:Int,type:String)
}
extension HTTPTool : TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    public var baseURL: URL {
        print("BaseURL:\(URLString)")
        return URL(string: URLString)!
    }
    
    public var path: String {
        switch self {
        case .LogIn:
            return "/login"
        case .getArticleDetailIndex:
            return "/api/article/getArticleDetailIndex"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .LogIn,.getArticleDetailIndex:
            return .post
            
        }
    }
    
    public var task: Task {
        switch self {
        case .LogIn(let name,let psw):
            return .requestCompositeParameters(bodyParameters: ["":""], bodyEncoding: JSONEncoding.default, urlParameters: ["client":deviceUUID!,"username":name,"password":psw,"os":"ios","brand":"apple","registrationId":""])
        case .getArticleDetailIndex(let page, let type):
            return .requestCompositeParameters(bodyParameters: ["":""], bodyEncoding: JSONEncoding.default, urlParameters: ["app_token":UserDefauTake(Key: ZToken)!,"client":deviceUUID!,"pageNumber":page,"type":type])
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .LogIn,.getArticleDetailIndex:
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
}
