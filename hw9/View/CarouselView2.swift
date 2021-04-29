//
//  CarouselView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/15/21.
//

import SwiftUI
import Kingfisher
//struct MovieView : View {
//
//
//    @Binding var showToast: Bool
//    @Binding var added: Bool
//    @Binding var title: String
//    @ObservedObject var movie : Movie
//    func watchlist(movie: Movie){
//        title = movie.title
//        var array = [Movie]()
//        if let data = defaults.data(forKey: "watchlist") {
//            do {
//                array = try JSONDecoder().decode([Movie].self, from: data)
//                if (!array.contains(movie)) { // not in watchlist
//                    do {
//                        array.append(movie)
//                        let data = try JSONEncoder().encode(array)
//                        defaults.set(data, forKey: "watchlist")
//                    } catch { print("Unable to Encode Array of Notes (\(error))") }
//
//                }
//                else {
//                    do {
//                        array.remove(at: array.firstIndex(of: movie)!)
//                        let data = try JSONEncoder().encode(array)
//                        defaults.set(data, forKey: "watchlist")
//                    } catch { print("Unable to Encode Array of Notes (\(error))") }
//                    added = true
//                }
//                print(array)
//            } catch { print("Unable to Decode Notes (\(error))") }
//        }
//        else {
//            array.append(movie)
//            do {
//                let data = try JSONEncoder().encode(array)
//                defaults.set(data, forKey: "watchlist")
//            }
//            catch { print("Unable to Encode Array of Notes (\(error))") }
//
//        }
//     movie.watchlist = true
//
//        if (!self.showToast) {
//            withAnimation {
//                self.showToast = true
//            }
//        }
//    }
//
//    func facebook(movie: Movie){
//        let full = "https://www.facebook.com/sharer/sharer.php?u=" + "https://www.themoviedb.org/" + movie.media_type + "/" + String(movie.id)
//        guard let url = URL(string: full) else { return }
//        UIApplication.shared.open(url)
//    }
//    func twitter(movie: Movie){
//        let text =  "Check out this link: "
//        let url = "https://www.themoviedb.org/" + movie.media_type + "/" + String(movie.id)
//        let hashtag = "CSCI571USCFilms"
//        let shareString = "https://twitter.com/intent/tweet?text=\(text)&url=\(url)&hashtags=\(hashtag)"
//
//        // encode a space to %20 for example
//        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//
//        // cast to an url
//        let tweetUrl = URL(string: escapedShareString)
//
//        // open in safari
//        UIApplication.shared.open(tweetUrl!)
//    }
//
//    var body: some View {
//        NavigationLink(destination: DetailView(id:movie.id, media_type: movie.media_type)) {
//            VStack{
//                KFImage(URL(string:  movie.backdrop_path ))
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 100)
//                    .cornerRadius(10.0)
//                    .clipped()
//                VStack{
//                    Text(movie.title).foregroundColor(Color.black).fontWeight(.bold).frame(width: 100).multilineTextAlignment(.center).lineLimit(10)
//                    Text("(" + movie.release_date + ")").foregroundColor(Color.gray)
//                }.background(Color.white)
//
//                    //
//            }.contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous)).contextMenu{
//                Button(action: {
//                 //   self.watchlist(movie: movie)
//                   // let _ = print("carousel: ", showToast)
//                }) {
//
//                    Text("\(movie.watchlist ? "Remove from watchList" : "Add to watchList")")
//                    Image(systemName: movie.watchlist ? "bookmark.fill" : "bookmark")
//                }
//                Button(action: {
//                 //   facebook(movie: movie)
//                }) {
//                    Text("Share on Facebook")
//                    Image("facebook")
//                }
//                Button(action: {
//                 //   twitter(movie: movie)
//                }) {
//                    Text("Share on Twitter")
//                    Image("twitter")
//                }
//            }
//        }.frame(width: 100)
//        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
//        .buttonStyle(PlainButtonStyle())
//    }
//}
struct CarouselView2: View {
    @Binding var showToast: Bool
    @Binding var added: Bool
    @Binding var title: String
    
    let headline: String
   var movies: [Movie]
    
    func watchlist(movie: Movie){
        title = movie.title
        var array = [Movie]()
        if let data = defaults.data(forKey: "watchlist") { // data exists in watchlist
            do {
                array = try JSONDecoder().decode([Movie].self, from: data)
                if (!array.contains(movie)) { // not in watchlist, ADD
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

        print(movie.watchlist)

        if (!self.showToast) {
            withAnimation {
                self.showToast = true
            }
        }
    }

    func facebook(movie: Movie){
        let full = "https://www.facebook.com/sharer/sharer.php?u=" + "https://www.themoviedb.org/" + movie.media_type + "/" + String(movie.id)
        guard let url = URL(string: full) else { return }
        UIApplication.shared.open(url)
    }
    func twitter(movie: Movie){
        let text =  "Check out this link: "
        let url = "https://www.themoviedb.org/" + movie.media_type + "/" + String(movie.id)
        let hashtag = "CSCI571USCFilms"
        let shareString = "https://twitter.com/intent/tweet?text=\(text)&url=\(url)&hashtags=\(hashtag)"

        // encode a space to %20 for example
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        // cast to an url
        let tweetUrl = URL(string: escapedShareString)

        // open in safari
        UIApplication.shared.open(tweetUrl!)
    }

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            Text(headline).font(.title).fontWeight(.bold)
            Spacer()
            ScrollView (.horizontal) {
                HStack(alignment: .top, spacing: 20){
                    ForEach(self.movies) {
                        movie in
                        //MovieView(showToast: $showToast, added: $added, title: $title, movie: movie)
                        NavigationLink(destination: DetailView(id:movie.id, media_type: movie.media_type)) {
                                    VStack{
                                        KFImage(URL(string:  movie.backdrop_path ))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100)
                                            .cornerRadius(10.0)
                                            .clipped()
                                        VStack{
                                            Text(movie.title).font(.caption).foregroundColor(Color.black).fontWeight(.bold).frame(width: 100).multilineTextAlignment(.center).lineLimit(10)
                                            Text("(" + movie.release_date + ")").font(.caption).foregroundColor(Color.gray)
                                        }.background(Color.white)
                        
                                            //
                                    }.contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous)).contextMenu{
                                        Button(action: {
                                            self.watchlist(movie: movie)
                                           let _ = print("carousel: ", showToast)
                                        }) {
                        
                                            Text("\(movie.watchlist ? "Remove from watchList" : "Add to watchList")")
                                            Image(systemName: movie.watchlist ? "bookmark.fill" : "bookmark")
                                        }
                                        Button(action: {
                                          facebook(movie: movie)
                                        }) {
                                            Text("Share on Facebook")
                                            Image("facebook")
                                        }
                                        Button(action: {
                                      twitter(movie: movie)
                                        }) {
                                            Text("Share on Twitter")
                                            Image("twitter")
                                        }
                                    }
                                }.frame(width: 100)
                                .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}
//
extension View {
    func toast<Content>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View where Content: View {
        Toast(
            isPresented: isPresented,
            presenter: { self },
            content: content
        )
    }
}

struct Toast<Presenting, Content>: View where Presenting: View, Content: View {
    @Binding var isPresented: Bool
    let presenter: () -> Presenting
    let content: () -> Content
    let delay: TimeInterval = 2
    
    var body: some View {
        if self.isPresented {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                withAnimation {
                    self.isPresented = false
                }
            }
        }
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.presenter()
                
                ZStack {
                    Capsule()
                        .fill(Color.gray)
                    self.content()
                } //ZStack (inner)
                .frame(width: geometry.size.width / 1.25, height: geometry.size.height / 10)
                .opacity(self.isPresented ? 1 : 0)
                
            } //ZStack (outer)
            .padding(.bottom)
        } //GeometryReader
    } //body
} //Toast

//struct CarouselView2_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView2(showToast: $showToast, title: "filler", movies: filler1)
//    }
//}
