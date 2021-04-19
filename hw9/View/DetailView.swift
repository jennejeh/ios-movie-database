//
//  DetailView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/16/21.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct DetailView: View {
    var id:Int
    @ObservedObject var detailVM = DetailVM()
    init(id:Int){
        self.id = id
        detailVM.load(id: self.id)
    }
    var body: some View {
        if detailVM.fetched == true {
            List{
                VStack{
                    Text(detailVM.movie.title)
                    Text(detailVM.movie.release_date)
                    Text(detailVM.movie.vote_average)
                    Text(detailVM.movie.overview)
                    Text("Cast & Crew").font(.largeTitle)
                    Container{
                        CastView(cast: detailVM.movie.cast)
                    }
                    Text("Reviews").font(.largeTitle)
                    Container{
                        ReviewView(reviews: detailVM.reviews)
                    }
                    Container{
                        CarouselView2(title: "Recommended", movies: detailVM.recommendedmovies)
                    }
                    
                }
            }
           
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 52199)
    }
}


