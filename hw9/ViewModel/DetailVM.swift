//
//  DetailVM.swift
//  hw9
//
//  Created by Jenny Jeh on 4/17/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class DetailVM: ObservableObject{
    @Published var fetched = false
    @Published var movie = Movie()
    @Published var cast = [castMember]()
    @Published var reviews = [review]()
    @Published var recommendedmovies = [Movie]()
//    init(){
//        
//    }
    func load(id: Int) {
        
        let parameters: Parameters = [
            "id": id
        ]

        var url = "http://127.0.0.1:8080/moviedetails"
        Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
            let json = JSON(data.data!)
            var lang = [String]()
            for x in json["spoken_languages"].stringValue {
                //                lang.append(x.stringValue)
            }
            self.movie = Movie(id: id, title: json["title"].stringValue, release_date: json["release_date"].stringValue, vote_average: json["vote_average"].stringValue + "/5.0", overview: json["overview"].stringValue, spoken_languages: lang)
            
           url = "http://127.0.0.1:8080/moviecast"
            Alamofire.request(url,method: .get, parameters: parameters).responseData{ [self] (data) in
                let json = JSON(data.data!)
                for x in json {
                    let c = castMember(profile_path: "https://image.tmdb.org/t/p/original" + x.1["profile_path"].stringValue,
                                       name: x.1["name"].stringValue)
                    self.movie.cast.append(c)

                }
                
                url = "http://127.0.0.1:8080/moviereviews"
                Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
                    let json = JSON(data.data!)
                  
                    for x in json {
                        let r = review(username: x.1["author_details"]["username"].stringValue,
                                       created_at: x.1["author_details"]["created_at"].stringValue,
                                       rating: x.1["author_details"]["rating"].stringValue,
                                       content:  x.1["content"].stringValue)
                        self.reviews.append(r)
                    }
                    
                    url = "http://127.0.0.1:8080/recommendedmovies"
                    Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
                        let json = JSON(data.data!)
                        for i in json["results"] {
                            let m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["release_date"].stringValue)
                            self.recommendedmovies.append(m)
                        }
                        
                    }
                    self.fetched = true
                }
                
            }
            
        }
    }
    
}
