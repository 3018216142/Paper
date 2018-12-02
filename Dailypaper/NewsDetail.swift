//
//  NewsDetail.swift
//  Dailypaper
//
//  Created by 王申宇 on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Alamofire

struct NewsDetailHelper {
    static func getNewsDetails(storyID: Int, success: @escaping (NewsDetail)->(), failure: @escaping (Error)->()) {
        NewsHelper.dataManager(url: "https://news-at.zhihu.com/api/4/news/\(storyID)", success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let newsDetail = try?NewsDetail(data: data) {
                success(newsDetail)
                
            }
        }, failure: { _ in
            
        })
    }
}


//MARK: - Model
struct NewsDetail: Codable {
    let body, imageSource, title: String
    let image: String
    let shareURL: String
    let js: [String]
    let gaPrefix: String
    let images: [String]
    let type, id: Int
    let css: [String]
    
    enum CodingKeys: String, CodingKey {
        case body
        case imageSource = "image_source"
        case title, image
        case shareURL = "share_url"
        case js
        case gaPrefix = "ga_prefix"
        case images, type, id, css
    }
}

// MARK: Convenience initializers and mutators

extension NewsDetail {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NewsDetail.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        body: String? = nil,
        imageSource: String? = nil,
        title: String? = nil,
        image: String? = nil,
        shareURL: String? = nil,
        js: [String]? = nil,
        gaPrefix: String? = nil,
        images: [String]? = nil,
        type: Int? = nil,
        id: Int? = nil,
        css: [String]? = nil
        ) -> NewsDetail {
        return NewsDetail(
            body: body ?? self.body,
            imageSource: imageSource ?? self.imageSource,
            title: title ?? self.title,
            image: image ?? self.image,
            shareURL: shareURL ?? self.shareURL,
            js: js ?? self.js,
            gaPrefix: gaPrefix ?? self.gaPrefix,
            images: images ?? self.images,
            type: type ?? self.type,
            id: id ?? self.id,
            css: css ?? self.css
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


