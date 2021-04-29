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
    @State var showToast : Bool = false
    @State var added: Bool = false
    @State var title: String = ""
 
    var body: some View {
        if !homeVM.fetched {
            ProgressView("Fetching Data...")
        }
        else {
            NavigationView{
                VStack{
                    if showMovie {
                        ScrollView {
                            Container{
                                CarouselView(title: "Now Playing", movies: homeVM.currentmovies)
                            }
                            Container{
                                CarouselView2(showToast: $showToast, added: $added, title: $title, headline: "Top Rated", movies: homeVM.topmovies)
                                
                            }
                            Container{
                                CarouselView2(showToast: $showToast, added: $added, title: $title, headline: "Popular", movies: homeVM.popularmovies)
                            }
                            
                        }
                    }
                    else {
                        ScrollView {
                        Container{
                            CarouselView(title: "Trending", movies: homeVM.trendingshows)
                        }
                        Container{
                            CarouselView2(showToast: $showToast, added: $added, title:  $title, headline: "Top Rated", movies: homeVM.topshows)
                        }
                        Container{
                            CarouselView2(showToast: $showToast, added: $added, title: $title, headline: "Popular", movies: homeVM.popularshows)
                        }
                        }
                    }
                }.navigationBarTitle("USC Films")
                .navigationBarItems(trailing:  Button(action: {
                    self.showMovie = !self.showMovie
                }, label: {
                    Text(self.showMovie ? "TV Shows" : "Movies")
                }))   
            }.toast(isPresented: $showToast) {
                HStack {
                    Text(title + "\(added ? " was removed from" : " was added to") Watchlist").multilineTextAlignment(.center)
                }
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView()
    }
}



