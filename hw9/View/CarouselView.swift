//
//  CarouselView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/15/21.
//

import SwiftUI
import Kingfisher
var filler = [ Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021"), Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021"),
               Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021"),
               Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021"),
               Movie(id: 1, title: "title", backdrop_path: "https://image.tmdb.org/t/p/w500/jpdWHOu6EJbYnLXLCA52h82nLEz.jpg", release_date: "2021")]

struct CarouselView: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        
        LazyVStack(alignment: .leading, spacing: 0) {
            Text(title).font(.title).fontWeight(.bold)
            Spacer()
            ScrollView {
                GeometryReader { geometry in
                    ImageCarouselView(numberOfImages: 5) {
                        ForEach(self.movies) {
                            movie in
                            NavigationLink(destination: DetailView(id:movie.id, media_type: movie.media_type)) {
                                ZStack (alignment: .center){
                                    KFImage(URL(string: movie.backdrop_path))
                                        .resizable().scaledToFill()
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .clipped()
                                   
                                        .blur(radius: 32)
                                    
                                    KFImage(URL(string: movie.backdrop_path))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 375, height: 300)
                                        .clipped()
                                }
                            }
                        }
                    }
                }.frame(height: 300, alignment: .center)
            }
        }
    }
}
//
//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView(title: "Current", movies: filler)
//    }
//}
