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
var movies = [movie]()
var currentmovies = [movie]()
var topmovies = [movie]()
var popularmovies = [movie]()
class HomeVM: ObservableObject {
    @Published var fetched = false
    init() {
        var url = "http://127.0.0.1:8080/currentmovies"
        Alamofire.request(url,method: .get).responseData{ (data) in
            let json = JSON(data.data!)
            print(json)
            for i in json["results"] {
                let m = movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["backdrop_path"].stringValue)
//                m.id = i.1["id"].intValue
//                m.title = i.1["title"].stringValue
//                m.backdrop_path = "https://image.tmdb.org/t/p/w500" + i.1["backdrop_path"].stringValue
                currentmovies.append(m)
            }
            url = "http://127.0.0.1:8080/topmovies"
            Alamofire.request(url,method: .get).responseData{ (data) in
                let json = JSON(data.data!)
                print(json)
                for i in json["results"] {
                    let m = movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["backdrop_path"].stringValue)
                    topmovies.append(m)
                }
                url = "http://127.0.0.1:8080/popularmovies"
                Alamofire.request(url,method: .get).responseData{ (data) in
                    let json = JSON(data.data!)
                    print(json)
                    for i in json["results"] {
                        let m = movie(id: i.1["id"].intValue, title: i.1["title"].stringValue, backdrop_path: "https://image.tmdb.org/t/p/w500" + i.1["backdrop_path"].stringValue)
                        popularmovies.append(m)
                    }
            }
            self.fetched = true
        }
   
    }
    }
}
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
                        VStack{
                            Text("USC Films")
                            Text("Now Playing")
                        }
                        
                        Container{
                            CarouselView(title: "Now Playing", movies: currentmovies)
                        }
                        Container{
                            CarouselView(title: "Top Rated Movies", movies: topmovies)
                        }
                        Container{
                            CarouselView(title: "Popular Movies", movies: popularmovies)
                        }
                        
                    }
                    else {
                        VStack{
                            Text("TV")
                        }
                    }
                }.navigationBarTitle("USC Films").navigationBarItems(trailing: Button("Movies"){
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



