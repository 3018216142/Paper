//
//  CommentsNews.swift
//  Dailypaper
//
//  Created by 王申宇 on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

struct NewsCommentsHelper {
    static func getComments(success: @escaping (NewsComments)->(), failure: @escaping (Error)->()) {
        NewsHelper.dataManager(url: "https://news-at.zhihu.com/api/4/news/\(NewsFigure.id)/comments", success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let newsComments = try? NewsComments(data: data) {
                success(newsComments)
            }
        }, failure: { _ in
            
        })
    }
}


struct NewsComments: Codable {
    let comments: [Comment]
    
    enum CodingKeys: String,CodingKey {
        case comments
    }
}

struct CommentsFigure {
    static var id = 0
}

struct Comment: Codable {
    let author, content: String
    let avatar: String
    let time, id, likes: Int
    
    enum CodingKeys: String, CodingKey {
        case author, content
        case avatar
        case time, id, likes
    }
}

// MARK: Convenience initializers and mutators

extension NewsComments {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NewsComments.self, from: data)
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
        comments: [Comment]? = nil
        ) -> NewsComments {
        return NewsComments(
            comments: comments ?? self.comments
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Comment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Comment.self, from: data)
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
        author: String? = nil,
        content: String? = nil,
        avatar: String? = nil,
        time: Int? = nil,
        id: Int? = nil,
        likes: Int? = nil
        ) -> Comment {
        return Comment(
            author: author ?? self.author,
            content: content ?? self.content,
            avatar: avatar ?? self.avatar,
            time: time ?? self.time,
            id: id ?? self.id,
            likes: likes ?? self.likes
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

