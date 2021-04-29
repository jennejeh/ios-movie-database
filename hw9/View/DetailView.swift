//
//  DetailView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/16/21.
//

import SwiftUI
import Alamofire
import Kingfisher
import SwiftyJSON
import youtube_ios_player_helper
extension String: Identifiable {
    public var id: String {
        self
    }
}

struct DetailView: View {
    var id:Int
    var media_type:String
    @State var loaded : Bool = false
    @State var showToast : Bool = false
    @State var added: Bool = false
    @State var title: String = ""
    @ObservedObject var VM = DetailVM()
    // @ObservedObject var detailVM2 = DetailVM2()
    init(id:Int, media_type: String){
        self.id = id
        self.media_type = media_type
        
    }
    //  @State var VM = DetailVM()
    @State var movie = Movie()
    var recommended = [Movie]()
    var body: some View {
        
        ScrollView{
            if (VM.fetched) {
                LazyVStack(alignment: .leading){
                    details(movie: VM.movie)
                    if (!VM.cast.isEmpty){
                        Text("Cast & Crew").font(.title).fontWeight(.bold)
                        Container{
                            CastView(cast: VM.cast) } }
                    if (!VM.reviews.isEmpty){
                        Text("Reviews").font(.title).fontWeight(.bold)
                      
                            ReviewView(reviews: VM.reviews, title: VM.movie.title)
                    }
                    RecommendedView(movies: VM.recommended, isMovie: self.media_type)
                }.padding(15)

            }
            else {
                ProgressView("Fetching Data...").toast(isPresented: $showToast) {
                    HStack {
                        Text(title + "\(added ? " was removed from" : " was added to") Watchlist").multilineTextAlignment(.center)
                    }
                }
            }
        }.toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ToolbarView(movie: VM.movie,showToast: $showToast, added: $added, title: $title, loaded: $VM.fetched)
            }
        }
        .onAppear{
            if (self.media_type == "movie") {
                VM.load(id: self.id, isMovie:true)
            }
            else  {
                VM.load(id: self.id, isMovie: false)
            }
            movie = VM.movie
        }
    }
}


struct YTWrapper : UIViewRepresentable {
    var videoID : String
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID, playerVars: ["playsinline" : 1])
        playerView.sizeToFit()
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        uiView.load(withVideoId: videoID, playerVars: ["playsinline" : 1])
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 52199, media_type: "movie")
    }
}

struct RecommendedView: View {
    let movies: [Movie]
    var isMovie : String
    var body: some View {
        if (!movies.isEmpty){
            if isMovie == "movie" {
                Text("Recommended Movies").font(.title).fontWeight(.bold)
            }
            else if isMovie == "tv" {
                Text("Recommended TV Shows").font(.title).fontWeight(.bold)
            }
            Container{
                
                LazyVStack(alignment: .leading, spacing: 0) {
                    ScrollView (.horizontal) {
                        HStack(alignment: .top, spacing: 30){
                            ForEach(movies) {
                                movie in
                                NavigationLink(destination: DetailView(id:movie.id, media_type: movie.media_type)) {
                                    VStack{
                                        KFImage(URL(string:  movie.backdrop_path ))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 110)
                                            .cornerRadius(10.0)
                                            .clipped()
                                    }
                                }.frame(width: 110)
                                .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct details: View {
    @State private var showMore = false
    var movie : Movie
    var body: some View {
        if (movie.trailer != "") {
           // let _ = print("Trailer")
            //let _ = print(movie.trailer)
            LazyVStack{
                YTWrapper(videoID: movie.trailer.replacingOccurrences(of: "\"", with: "")).frame(height: 200)
            }
        }

            Text(movie.title).font(.title).fontWeight(.bold).fixedSize(horizontal: false, vertical: true)
            Spacer()
            let string = movie.genres.joined(separator: ", ")
            Text(movie.release_date + " | " + string)
            Spacer()
            HStack {
                Image(systemName: "star.fill").foregroundColor(Color.red)
                Text(movie.vote_average).frame(alignment: .leading)
            }
            Spacer()
            if (showMore) {
                Text(movie.overview).fixedSize(horizontal: false, vertical: true)
            }
            else {
                Text(movie.overview).lineLimit(3)
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    showMore.toggle()
                }) {
                    Text(self.showMore ? "Show less.." : "Show more..").foregroundColor(Color.gray).frame(alignment: .trailing)
                }
            }
            

        
    }
    
    
}
struct ToolbarView: View {
    var movie : Movie
    @Binding var showToast: Bool
    @Binding var added: Bool
    @Binding var title: String
    @Binding var loaded : Bool
    func watchlist(movie: Movie){
        title = movie.title
        var array = [Movie]()
        if let data = defaults.data(forKey: "watchlist") { // data exists in watchlist
            do {
                array = try JSONDecoder().decode([Movie].self, from: data)
                if (!array.contains(movie)) { // not in watchlist, ADD
                    let _ = print("ADDED ", movie.title)
                    do {
                        array.append(movie)
                        let data = try JSONEncoder().encode(array)
                        defaults.set(data, forKey: "watchlist")
                    } catch { print("Unable to Encode Array of Notes (\(error))") }
                    movie.watchlist = true
                    
                }
                else { // in watchlist, REMOVE
                    do {
                        array.remove(at: array.firstIndex(of: movie)!)
                        let data = try JSONEncoder().encode(array)
                        defaults.set(data, forKey: "watchlist")
                    } catch { print("Unable to Encode Array of Notes (\(error))") }
                    added = true
                    movie.watchlist = false
                }
            } catch { print("Unable to Decode Notes (\(error))") }
        }
        else { // watchlist empty, ADD
            array.append(movie)
            do {
                let data = try JSONEncoder().encode(array)
                defaults.set(data, forKey: "watchlist")
            }
            catch { print("Unable to Encode Array of Notes (\(error))") }
            movie.watchlist = true
        }
        
      //  print(movie.watchlist)
        
        if (!self.showToast) {
            withAnimation {
                self.showToast = true
            }
        }
    }
    func facebook(movie: Movie){
        let full = "https://www.facebook.com/sharer/sharer.php?u=" + "https://www.themoviedb.org/" + movie.media_type + "/" + String(movie.id)
        guard let url = URL(string: full) else { return }
        let _ = print(url)
        UIApplication.shared.open(url)
    }
    func twitter(movie: Movie){
        let text =  "Check out this link: "
        let url = "https://www.themoviedb.org/" + movie.media_type + "/" + String(movie.id)
        let hashtag = "CSCI571USCFilms"
        let shareString = "https://twitter.com/intent/tweet?text=\(text)&url=\(url)&hashtags=\(hashtag)"
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let tweetUrl = URL(string: escapedShareString)
        UIApplication.shared.open(tweetUrl!)
    }
    
    var body: some View {
        if (loaded) {
            HStack {
//                Button(action: {
//                    print(movie.watchlist)
//                    watchlist(movie: movie)
//                    showToast.toggle()
//                }) {
//                    let _ =  print(movie.watchlist)
//                    let _ =  print(movie.title)
//
//                    Image(systemName: movie.watchlist ? "bookmark.fill" : "bookmark")
//                }
                Label("", systemImage : (movie.watchlist ? "bookmark.fill" : "bookmark")).foregroundColor(Color.black).onTapGesture{
                   // print(movie.watchlist)
                    self.watchlist(movie: movie)
                    showToast.toggle()
                }
                 //   let _ =  print(movie.watchlist)
                   // let _ =  print(movie.title)
                    
                    
                
                Button(action: {
                    facebook(movie:movie)
                }) {
                    Image("facebook").resizable().scaledToFit()
                }
                Button(action: {
                    twitter(movie:movie)
                }) {
                    Image("twitter").resizable().scaledToFit()
                }
            }.frame(height: 30.0)
        }
   
    }
}
