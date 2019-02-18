//
//  ReviewParser.swift
//  GetReview
//
//  Created by 홍창남 on 19/02/2019.
//  Copyright © 2019 홍창남. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Author {
    let uri: String
    let name: String
}

struct Review {
    let author: Author
    let appVersion: String
    let rating: String
    let title: String
    let content: String
}

class ReviewParser {

    func getReview(pageNo: Int, appID: Int, completionHandler: @escaping () -> Void) {

        guard let url = URL(string: "https://itunes.apple.com/kr/rss/customerreviews/page=\(pageNo)/id=\(appID)/sortBy=mostRecent/json") else {
            return
        }
//393499958

        var urlRequest = URLRequest(url: url)

        urlRequest.timeoutInterval = 10
        urlRequest.httpMethod = "GET"

        let session = URLSession(configuration: .default)

        session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print(error)
                return
            }

            guard let data = data, let json = try? JSON(data: data) else { return }

            let reviews: [Review] = json["feed"]["entry"].arrayValue.compactMap { reviewInfo in

                let title = reviewInfo["title"]["label"].stringValue
                let content = reviewInfo["content"]["label"].stringValue
                let appVersion = reviewInfo["im:version"]["label"].stringValue
                let rating = reviewInfo["im:rating"]["label"].stringValue

                let authorURI = reviewInfo["author"]["uri"]["label"].stringValue
                let authorName = reviewInfo["author"]["name"]["label"].stringValue

                let author = Author(uri: authorURI, name: authorName)

                let review = Review(author: author, appVersion: appVersion, rating: rating, title: title, content: content)

                print(review)
                return review
            }

            completionHandler()
        }.resume()
    }
}


