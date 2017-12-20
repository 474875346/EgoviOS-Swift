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
let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    let type = response.suggestedFilename!.components(separatedBy: ".")[1]
    let name = "附件"+"."+type
    return (DefaultDownloadDir.appendingPathComponent(name), [])
}
let DefaultDownloadDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first!
}()
let HttpTool = MoyaProvider<HTTPTool>()
enum HTTPTool {
    //登录
    case LogIn(Name:String,Psw:String)
    //通知
    case getArticleDetailIndex(page:Int,type:String)
    //通知详情
    case getArticleView(articleId:String)
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
        case .getArticleView:
            return "/api/article/getArticleView"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        case .LogIn(let name,let psw):
            return .requestCompositeParameters(bodyParameters: ["":""], bodyEncoding: JSONEncoding.default, urlParameters: ["client":deviceUUID!,"username":name,"password":psw,"os":"ios","brand":"apple","registrationId":""])
        case .getArticleDetailIndex(let page, let type):
            return .requestCompositeParameters(bodyParameters: ["":""], bodyEncoding: JSONEncoding.default, urlParameters: ["app_token":UserDefauTake(Key: ZToken)!,"client":deviceUUID!,"pageNumber":page,"type":type])
        case .getArticleView(let articleId):
            return .requestCompositeParameters(bodyParameters: ["":""], bodyEncoding: JSONEncoding.default, urlParameters: ["app_token":UserDefauTake(Key: ZToken)!,"client":deviceUUID!,"articleId":articleId])
        }
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
