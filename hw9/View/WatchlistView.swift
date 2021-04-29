//
//  WatchlistView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/18/21.
//

import SwiftUI
import Kingfisher
let defaults = UserDefaults.standard
struct WatchlistView: View {
    private var columns: [GridItem] = [
        GridItem(.fixed(120), spacing: 5),
        GridItem(.fixed(120), spacing: 5),
        GridItem(.fixed(120), spacing: 5)
    ]
    @State var movies = [Movie]()
    
    var body: some View {
        
        ScrollView {
            if (movies.isEmpty) {
                Text("Watchlist is empty").font(.title).foregroundColor(Color.gray).frame(alignment: .center)
            }
            else {
                Text("Watchlist").frame(width: 350, alignment: .leading).font(.title)
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 3
                ) {
                    ForEach(movies) {
                        movie in
                        let _ = print(movie.title)
                        NavigationLink(destination: DetailView(id:movie.id, media_type: movie.media_type)) {
                        KFImage(URL(string:  movie.backdrop_path ))
                            .resizable()
                            .frame(width: 120, height: 180)                    
                            .clipped()
                        }
//                        .onDrag {
//                            return NSItemProvider(contentsOf: URL(movie.title))
//                        }
//                        .onDrop(of: [.text], delegate: DropViewDelegate)
                    }
                }
            }
            
        }.frame(alignment: .leading).onAppear{
            movies = help()
        }
        
        
    }
    func help() -> [Movie]{
        var array = [Movie]()
        if let data = defaults.data(forKey: "watchlist") {
            do {
                array = try JSONDecoder().decode([Movie].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        for i in array.indices {
            array[i].watchlist = true
        }
        return array
    }
}
struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
struct DropViewDelegate: DropDelegate{
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    func dropEntered(info: DropInfo) {
    
    }
    
}

