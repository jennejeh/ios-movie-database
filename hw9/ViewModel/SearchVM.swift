//
//  DetailVM.swift
//  hw9
//
//  Created by Jenny Jeh on 4/17/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchVM: ObservableObject{
    @Published var fetched = false
    @Published var results = [Movie]()

    func load(query: String) {
        results = []
        print("SEARCH CALLED")
        let parameters: Parameters = [
            "query": query
        ]
        
        let base = "http://127.0.0.1:8080/"
        let url = base + "multi"
        Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
            let json = JSON(data.data!)
            for i in json {
            
                let m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: i.1["backdrop_path"].stringValue, release_date: i.1["release_date"].stringValue, vote_average: i.1["vote_average"].stringValue, media_type: i.1["media_type"].stringValue)
                
                self.results.append(m)
          
            }
            self.fetched = true
        }
    }
}
