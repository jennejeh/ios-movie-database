//
//  movie.swift
//  hw9
//
//  Created by Jenny Jeh on 4/15/21.
//

import Foundation


class Movie: Identifiable, Equatable, Codable {
  
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(id: Int? = nil, title: String? = nil, backdrop_path: String? = nil, release_date: String? = nil, vote_average: String? = nil, overview: String? = nil,  poster_path: String? = nil, genres: [String]? = nil, spoken_languages: [String]? = nil, cast: [castMember]? = nil, media_type: String? = nil, trailer: String? = nil, watchlist: Bool? = nil){
        self.id = id ?? 0
        self.title = title ?? ""
        self.backdrop_path = backdrop_path ?? ""
        self.release_date = release_date ?? ""
        self.vote_average = vote_average ?? ""
        self.overview = overview ?? ""
        self.poster_path = poster_path ?? ""
        self.genres = genres ?? []
        self.spoken_languages = spoken_languages ?? []
        self.cast = cast ?? []
        self.media_type = media_type ?? ""
        self.trailer = trailer ?? ""
        self.watchlist = watchlist ?? false
    }
    let id: Int
    let title: String
    let backdrop_path: String
    let release_date: String
    let vote_average: String
    let overview: String
    let genres: [String]
    let spoken_languages: [String]
    let poster_path: String
    var cast: [castMember]
    let media_type: String
    let trailer: String
    var watchlist: Bool
}


struct castMember: Identifiable, Codable {
    init(id: Int? = nil, title: String? = nil, profile_path: String? = nil, name: String? = nil){
        self.id = id ?? 0
        self.profile_path = profile_path ?? ""
        self.name = name ?? ""
    }
    let id : Int
    let profile_path: String
    let name: String
}
//var cast = [castMember]()

struct review: Identifiable {
    init(id: Int? = nil, username: String? = nil, created_at: String? = nil, rating: String? = nil, content: String? = nil){
        self.id = id ?? 0
        
        self.username = username ?? ""
        self.created_at = created_at ?? ""
        self.rating = rating ?? ""
        self.content = content ?? ""
        
    }
    let id : Int
    let username: String
    let created_at: String
    let rating: String
    let content: String
}
//var reviews = [review]()
