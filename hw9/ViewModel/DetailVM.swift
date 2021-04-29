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
    @Published var cast: [castMember] = []
    @Published var reviews: [review] = []
    @Published var recommended: [Movie] = []
    
    //    init(){
    //        
    //    }
    func load(id: Int, isMovie: Bool) {
        let parameters: Parameters = [
            "id": id
        ]
        let base = "http://127.0.0.1:8080/"
        if isMovie {
            var url = base + "moviedetails"
            Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
                var trailer = ""
                let json = JSON(data.data!)
                // print(json)
                url = base + "movievideo"
                Alamofire.request(url ,method: .get, parameters: parameters).responseString{ (data) in
                    trailer = data.result.value!
                    var genres = [String]()
                    for x in json["genres"] {
                        genres.append(x.1.stringValue)
                    }
                    self.movie = Movie(id: id, title: json["title"].stringValue, release_date: json["release_date"].stringValue, vote_average: json["vote_average"].stringValue + "/5.0", overview: json["overview"].stringValue, genres: genres, media_type: "movie", trailer: trailer)
                }
                url = base + "moviecast"
                Alamofire.request(url,method: .get, parameters: parameters).responseData{ [self] (data) in
                    self.cast = []
                    let json = JSON(data.data!)
                    for x in json {
                        let c = castMember(id: x.1["id"].intValue, profile_path: "https://image.tmdb.org/t/p/original" + x.1["profile_path"].stringValue,
                                           name: x.1["name"].stringValue)
                        self.cast.append(c)
                        
                    }
                    
                    url = base + "moviereviews"
                    Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
                        let json = JSON(data.data!)
                        self.reviews = []
                        for x in json {
                            let r = review(id: x.1["id"].intValue, username: x.1["author_details"]["username"].stringValue,
                                           created_at: x.1["created_at"].stringValue,
                                           rating: x.1["author_details"]["rating"].stringValue,
                                           content:  x.1["content"].stringValue)
                            self.reviews.append(r)
                        }
                        
                        url = base + "recommendedmovies"
                        Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
                            let json = JSON(data.data!)
                            for i in json["results"] {
                                let m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["release_date"].stringValue)
                                self.recommended.append(m)
                            }
                            //  print("FETCHED")
                            self.fetched = true
                        }
                    }
                }
                
            }
            
        }
        else {
            print("TV")
            var url = base + "tvdetails"
            Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
                var trailer = ""
                let json = JSON(data.data!)
                url = base + "tvvideo"
                Alamofire.request(base + "tvvideo",method: .get, parameters: parameters).responseString{ (data) in
                    trailer = data.result.value!
                    var genres = [String]()
                    for x in json["genres"] {
                        genres.append(x.1.stringValue)
                    }
                    self.movie = Movie(id: id, title: json["name"].stringValue, release_date: json["first_air_date"].stringValue, vote_average: json["vote_average"].stringValue + "/5.0", overview: json["overview"].stringValue, genres: genres, media_type: "tv", trailer: trailer)
                }
                
                url = base + "tvcast"
                Alamofire.request(url,method: .get, parameters: parameters).responseData{ [self] (data) in
                    let json = JSON(data.data!)
                    for x in json {
                        let c = castMember(id: x.1["id"].intValue, profile_path: "https://image.tmdb.org/t/p/original" + x.1["profile_path"].stringValue,
                                           name: x.1["name"].stringValue)
                        self.cast.append(c)
                    }
                    url = base + "tvreviews"
                    Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
                        let json = JSON(data.data!)
                        for x in json {
                            let r = review(id: x.1["id"].intValue, username: x.1["author_details"]["username"].stringValue,
                                           created_at: x.1["created_at"].stringValue,
                                           rating: x.1["author_details"]["rating"].stringValue,
                                           content:  x.1["content"].stringValue)
                            self.reviews.append(r)
                        }
                        
                        url = base + "recommendedshows"
                        Alamofire.request(url,method: .get, parameters: parameters).responseData{ (data) in
                            let json = JSON(data.data!)
                            for i in json["results"] {
                                let m = Movie(id: i.1["id"].intValue, title: i.1["name"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["first_air_date"].stringValue)
                                self.recommended.append(m)
                            }
                            self.fetched = true
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    
}
