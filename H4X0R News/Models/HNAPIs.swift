//
//  HNAPIs.swift
//  H4X0R News
//
//  Created by Eremej Sumcenko on 03.03.2021.
//

import Foundation

struct HNAPIs {
    static private let baseUrl = "https://hn.algolia.com/api/v1/"
    static private let tagsParam = "tags="
    static private let pageParam = "page="
    static private let queryParam = "query="

    
    enum Tags: String {
        case story
        case comment
        case poll
        case pollopt
        case show_hn
        case ask_hn
        case front_page
    }
    
    static let firstPage = 0
    
    /**
     All stories that are on the front/home page right now
     */
    static func getHomePageStories(at page: Int) -> URL {
        let req = "\(baseUrl)search?\(tagsParam + Tags.front_page.rawValue)&\(pageParam + String(page))"
        
        return URL(string: req)!
    }
    
    /**
     All stories matching given query
     */
    static func getStories(matching query: String, at page: Int) -> URL {
        let req = "\(baseUrl)search?\(tagsParam + Tags.story.rawValue)&\(queryParam + query)&\(pageParam + String(page))"
        
        return URL(string: req)!
    }
    
    /**
     All comments matching given query
     */
    static func getComments(matching query: String, at page: Int) -> URL {
        let req = "\(baseUrl)search?\(tagsParam + Tags.comment.rawValue)&\(queryParam + query)&\(pageParam + String(page))"
        
        return URL(string: req)!
    }
    
    /**
     Last stories
     */
    static func getLastStories(at page: Int) -> URL {
        let req = "\(baseUrl)search_by_date?\(tagsParam + Tags.story.rawValue)&\(pageParam + String(page))"
        
        return URL(string: req)!
    }
    
    
    struct HNResponse: Decodable {
        struct Post: Decodable, Identifiable {
            var id: String {
                return objectID
            }
            let objectID: String
            let title: String
            let url: String?
            let points: Int
        }
        
        let hits: [Post]
        let page: Int
        let nbHits: Int
        let nbPages: Int
        let hitsPerPage: Int
    }
    
}
