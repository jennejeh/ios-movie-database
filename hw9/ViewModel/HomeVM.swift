//
//  HomeVM.swift
//  hw9
//
//  Created by Jenny Jeh on 4/17/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeVM: ObservableObject {
    @Published var fetched = false
    @Published var currentmovies = [Movie]()
    @Published var topmovies = [Movie]()
    @Published var popularmovies = [Movie]()
    @Published var trendingshows = [Movie]()
    @Published var topshows = [Movie]()
    @Published var popularshows = [Movie]()

    init() {
        var url = "http://127.0.0.1:8080/currentmovies"
        Alamofire.request(url,method: .get).responseData{ (data) in
            let json = JSON(data.data!)
           
            for i in json["results"] {
                let m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["backdrop_path"].stringValue, release_date: i.1["release_date"].stringValue)

                self.currentmovies.append(m)
            }
            url = "http://127.0.0.1:8080/topmovies"
            Alamofire.request(url,method: .get).responseData{ (data) in
                let json = JSON(data.data!)
                
                for i in json["results"] {
                    let m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["release_date"].stringValue)
                    self.topmovies.append(m)
                }
                url = "http://127.0.0.1:8080/popularmovies"
                Alamofire.request(url,method: .get).responseData{ (data) in
                    let json = JSON(data.data!)
                
                    for i in json["results"] {
                        let m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["release_date"].stringValue)
                        self.popularmovies.append(m)
                    }
                    url = "http://127.0.0.1:8080/trendingshows"
                    Alamofire.request(url,method: .get).responseData{ (data) in
                        let json = JSON(data.data!)
                        
                        for i in json["results"] {
                            let m = Movie(id: i.1["id"].intValue, title: i.1["name"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["backdrop_path"].stringValue, release_date: i.1["first_air_date"].stringValue)
                            self.trendingshows.append(m)
                        }
                        url = "http://127.0.0.1:8080/topshows"
                        Alamofire.request(url,method: .get).responseData{ (data) in
                            let json = JSON(data.data!)
                      
                            for i in json["results"] {
                                let m = Movie(id: i.1["id"].intValue, title: i.1["name"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["first_air_date"].stringValue)
                                self.topshows.append(m)
                            }
                            url = "http://127.0.0.1:8080/popularshows"
                            Alamofire.request(url,method: .get).responseData{ (data) in
                                let json = JSON(data.data!)
                   
                                for i in json["results"] {
                                    let m = Movie(id: i.1["id"].intValue, title: i.1["name"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["first_air_date"].stringValue)
                                    self.popularshows.append(m)
                                }
                                self.fetched = true
                            }
                        }
                    }
                }
             
            }
            
        }
    }
}
