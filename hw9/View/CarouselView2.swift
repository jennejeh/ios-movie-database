//
//  CarouselView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/15/21.
//

import SwiftUI
import Kingfisher
var filler1 = [ Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021"), Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021"),
               Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021"),
               Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021"),
               Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021")]
struct CarouselView2: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.title).fontWeight(.bold).padding(.horizontal)
            
            ScrollView (.horizontal) {
                HStack(alignment: .top, spacing: 16){
                    ForEach(self.movies) {
                        movie in
                        NavigationLink(destination: DetailView(id:movie.id)) {
                            VStack{
                            KFImage(URL(string:  movie.backdrop_path ))
                                .resizable()
                                .frame(width: 100, height: 150)
                                .clipped()
                                .contextMenu {
                                    Button(action: {
                                    }) {
                                        Text("Remove from watchList")
                                        Image(systemName: "bookmark.fill")
                                    }
                                    Button(action: {
                                        
                                    }) {
                                        Text("Share on Facebook")
                                        Image(systemName: "facebook")
                                    }
                                    Button(action: {
                                        
                                    }) {
                                        Text("Share on Twitter")
                                        Image(systemName: "twitter")
                                    }
                                }
                            Text(movie.title)
                            Text(movie.release_date)
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                    }
                }
            }
        }
        }
    }
}
//
struct CarouselView2_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView2(title: "filler", movies: filler1)
    }
}
