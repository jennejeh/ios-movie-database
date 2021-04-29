//
//  ContentView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/14/21.
//

import SwiftUI
import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher


//var showMovie = UIButton(type: UIButton.ButtonType.system)
//class TestViewModel: ObservableObject {
//
//    init() {
//
//let url = "http://127.0.0.1:8080/currentmovies"
//        Alamofire.request(url,method: .get).responseData{ (data) in
//
//            let json = JSON(data.data!)
//      print(json)
//            for i in json["results"] {
//                var m = movie()
//                m.id = i.1["id"].intValue
//                m.title = i.1["title"].stringValue
//                m.backdrop_path = "https://image.tmdb.org/t/p/w500" + i.1["backdrop_path"].stringValue
//                movies.append(m)
//                print(m.id)
//              }
//            print(movies[0].backdrop_path)
//
//        }
//    }
//}
struct ContentView: View {
    @StateObject var hm = HomeVM()
    @State private var selection = 1
    var content = "content"
    var body: some View {
        TabView(selection: $selection) {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(2)
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)
            WatchlistView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "heart")
                    Text("Watchlist")
                }
                .tag(3)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





