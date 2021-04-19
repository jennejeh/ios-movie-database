//
//  HomeView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/14/21.
//
import SwiftUI
import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher


struct HomeView: View {
    @StateObject var homeVM = HomeVM()
    @State private var showMovie = true
    
    var body: some View {
        if homeVM.fetched == false {
            ProgressView("Fetching Data...")
        }
        else {
            NavigationView{
                VStack{
                    if showMovie {
                        Toggle("", isOn: $showMovie)
                        ScrollView {
                            Container{
                                CarouselView(title: "Now Playing", movies: homeVM.currentmovies)
                            }
                            Container{
                                CarouselView2(title: "Top Rated", movies: homeVM.topmovies)
                            }
                            Container{
                                CarouselView2(title: "Popular", movies: homeVM.popularmovies)
                            }
                            
                        }
                    }
                    else {
                        Toggle("", isOn: $showMovie)
                        
                        Container{
                            CarouselView(title: "Trending", movies: homeVM.trendingshows)
                        }
                        Container{
                            CarouselView2(title: "Top Rated", movies: homeVM.topshows)
                        }
                        Container{
                            CarouselView2(title: "Popular", movies: homeVM.popularshows)
                        }
                    }
                }.navigationBarTitle("USC Films")
                .navigationBarItems(trailing: Button("Movies"){
                                        showMovie.toggle()})
                
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView()
    }
}



