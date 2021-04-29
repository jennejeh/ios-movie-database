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
    func watchlist(movie: Movie) ->Bool{
        var array = [Movie]()
        if let data = defaults.data(forKey: "watchlist") { // watchlist exists
            do {
                array = try JSONDecoder().decode([Movie].self, from: data)
                if (!array.contains(movie)) { // not in watchlist
                    return false
                }
                else { // in watchlist 
                    return true
                }
            } catch { print("Unable to Decode Notes (\(error))") }
           
        }
    
            return false

       
    }
    init() {
        var url = "http://127.0.0.1:8080/currentmovies"
        Alamofire.request(url,method: .get).responseData{ (data) in
            let json = JSON(data.data!)
           
            for i in json["results"] {
                var m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["release_date"].stringValue, media_type: "movie")
                m.watchlist = self.watchlist(movie: m)

                self.currentmovies.append(m)
            }
            url = "http://127.0.0.1:8080/topmovies"
            Alamofire.request(url,method: .get).responseData{ (data) in
                let json = JSON(data.data!)
                
                for i in json["results"] {
                    var m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["release_date"].stringValue, media_type: "movie")
                    m.watchlist = self.watchlist(movie: m)
                    self.topmovies.append(m)
                }
                url = "http://127.0.0.1:8080/popularmovies"
                Alamofire.request(url,method: .get).responseData{ (data) in
                    let json = JSON(data.data!)
                
                    for i in json["results"] {
                        var m = Movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["release_date"].stringValue, media_type: "movie")
                        m.watchlist = self.watchlist(movie: m)
                        self.popularmovies.append(m)
                    }
                    url = "http://127.0.0.1:8080/trendingshows"
                    Alamofire.request(url, method: .get).responseData{ (data) in
                      
                        let json = JSON(data.data!)
                      
                        for i in json["results"] {
                            var m = Movie(id: i.1["id"].intValue, title: i.1["name"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["first_air_date"].stringValue, media_type: "tv")
                            m.watchlist = self.watchlist(movie: m)
                            self.trendingshows.append(m)
                        }
                        url = "http://127.0.0.1:8080/topshows"
                        Alamofire.request(url,method: .get).responseData{ (data) in
                            let json = JSON(data.data!)
                      
                            for i in json["results"] {
                                var m = Movie(id: i.1["id"].intValue, title: i.1["name"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["first_air_date"].stringValue, media_type: "tv")
                                m.watchlist = self.watchlist(movie: m)
                                self.topshows.append(m)
                            }
                            url = "http://127.0.0.1:8080/popularshows"
                            Alamofire.request(url,method: .get).responseData{ (data) in
                                let json = JSON(data.data!)
                   
                                for i in json["results"] {
                                    var m = Movie(id: i.1["id"].intValue, title: i.1["name"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["poster_path"].stringValue, release_date: i.1["first_air_date"].stringValue, media_type: "tv")
                                    m.watchlist = self.watchlist(movie: m)
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
