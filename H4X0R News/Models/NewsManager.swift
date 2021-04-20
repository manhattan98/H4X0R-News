//
//  NewsManager.swift
//  H4X0R News
//
//  Created by Eremej Sumcenko on 03.03.2021.
//

import Foundation

class NewsManager: ObservableObject {
    // MARK: - Properties
    /**
     Current fetched posts
     */
    @Published var posts = [HNAPIs.HNResponse.Post]()
    
    
    private var nextPage = HNAPIs.firstPage
    
    private let urlProvider: (Int) -> URL
    
    // MARK: - Initializers
    init(newsProvider: @escaping (Int) -> URL) {
        urlProvider = newsProvider
    }
    
    init() {
        urlProvider = HNAPIs.getHomePageStories(at:)
    }
    
    // MARK: - Methods
    /**
     Fetch next page, starting from first page
     */
    func fetch() {
        fetch(at: nextPage)
    }
    /**
     Fetch given page
     */
    func fetch(at page: Int) {
        let fetchURL = urlProvider(page)
        
        URLSession(configuration: .default)
            .dataTask(with: fetchURL) { (data, response, error) in
                if let dataReceived = data {
                    do {
                        let newsResponse = try JSONDecoder().decode(HNAPIs.HNResponse.self, from: dataReceived)
                        
                        print("\nSuccessfully received \(newsResponse.hits.count) items\n")
                        DispatchQueue.main.async {
                            self.nextPage = page + 1
                            
                            self.posts.append(contentsOf: newsResponse.hits)
                        }
                    } catch let decodingError {
                        print(decodingError)
                    }
                }
                if let errorHappened = error {
                    print(errorHappened)
                }
            }
            .resume()
    }
}
