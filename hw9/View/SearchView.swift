//
//  SearchView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/17/21.
//

import SwiftUI
import Kingfisher

struct ImageOverlay: View {
    @State var text: String
    @State var img : Image?
    var body: some View {
        ZStack {
            Text(text.uppercased()).bold()
                .padding(6)
                .foregroundColor(.white)
                .font(.headline)
        }
        .cornerRadius(10.0)
    }
}
struct ImageOverlay1: View {
    @State var text: String
    @State var img : Image?
    var body: some View {
        ZStack {
            Text(text).bold()
                .padding(6)
                .foregroundColor(.white)
                .font(.headline)
        }
        .cornerRadius(10.0)
    }
}
struct ImageOverlay2: View {
    @State var text: String
    var body: some View {
        ZStack {
            HStack{
                Image(systemName: "star.fill").foregroundColor(Color.red)
                Text(text.uppercased()).bold()
                    .padding(6)
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .cornerRadius(10.0)
//        .padding(6)
    }
}
struct SearchResultView: View {
    var results : [Movie]

    var body: some View {
        ScrollView {
           // if (!empty) {
                VStack(alignment: .center){
                    ForEach(results) { movie in
                    //    GeometryReader { geometry in
                        NavigationLink(destination: DetailView(id:movie.id, media_type: movie.media_type)) {
                            let _ = print(movie.title)
                                KFImage(URL(string:  movie.backdrop_path ))
                                    .resizable()
                                    .cornerRadius(10.0)
                                    .frame(height: 200, alignment: .center)
                                    .clipped()
                                    .scaledToFit()
                                    .overlay(ImageOverlay(text: movie.media_type + movie.release_date), alignment: .topLeading)
                                    .overlay(ImageOverlay1(text: movie.title), alignment: .bottomLeading)
                                    .overlay(ImageOverlay2(text: movie.vote_average), alignment: .topTrailing)
                                    .padding(10)
                                    
                        }
                    }
                
                }
//                    }
//                    else if empty {
//                        Text("No results found").foregroundColor(Color.gray).font(.headline)
//                    }
            
        }
    }
}
struct SearchView: View {
    @State var input: String = ""
    @State var empty: Bool = false
    var debouncer = Debouncer(delay: 0.5)
    @StateObject var searchVM = SearchVM()
    
    var body: some View {
        NavigationView {
            VStack {
               // SearchBar(text: $input, onTextChanged: searchMovies)
                SearchBar(text: $input, searchVM: searchVM, empty: $empty)
                let _ = print(searchVM.results)
                SearchResultView(results: searchVM.results)
              
            }.navigationBarTitle(Text("Search")
            )
        }
    }
   
}
struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var searchVM : SearchVM
    @Binding var empty: Bool
   
   // var onTextChanged: (String) -> Void
   
    class Coordinator: NSObject, UISearchBarDelegate {
       // var onTextChanged: (String) -> Void
        @Binding var text: String
    
        var searchVM : SearchVM
        var debouncer = Debouncer(delay: 0.5)
        
        init(text: Binding<String>, searchVM: SearchVM) {
            _text = text
            self.searchVM = searchVM
       //     self.onTextChanged = onTextChanged
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
          //  onTextChanged(text)
            searchMovies(input: text)
        }
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

           searchBar.setShowsCancelButton(true, animated: true)

        }
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

            searchBar.setShowsCancelButton(false, animated: true)
        }
        func searchMovies(input: String) {
           // empty = false
            if (!input.isEmpty && input.count > 2) {
                debouncer.run(action: {
                    self.searchVM.load(query: input)
                })
               // print(searchVM.results)
                if searchVM.fetched && !searchVM.results.isEmpty {
                 //   empty = true
                }
            }
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchVM.results = []
            searchBar.text = nil
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, searchVM: searchVM)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search Movies, TVs..."
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}


//struct SearchBar: UIViewRepresentable {
//    @Binding var text: String
////    var searchVM : SearchVM = SearchVM()
////    var debouncer = Debouncer(delay: 0.5)
//    var onTextChanged: (String) -> Void
//
//    class Coordinator: NSObject, UISearchBarDelegate {
//        var onTextChanged: (String) -> Void
//        @Binding var text: String
//
//        init(text: Binding<String>, onTextChanged: @escaping (String) -> Void) {
//            _text = text
//            self.onTextChanged = onTextChanged
//        }
//
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            text = searchText
//            onTextChanged(text)
//        }
//    }
//
//    func makeCoordinator() -> SearchBar.Coordinator {
//        return Coordinator(text: $text, onTextChanged: onTextChanged)
//    }
//
//    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
//        let searchBar = UISearchBar(frame: .zero)
//        searchBar.delegate = context.coordinator
//        searchBar.placeholder = "Search Movies, TVs..."
//        searchBar.searchBarStyle = .minimal
//        searchBar.autocapitalizationType = .none
//        return searchBar
//    }
//
//    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
//        uiView.text = text
//    }
//}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(input: "mulan")
    }
}
