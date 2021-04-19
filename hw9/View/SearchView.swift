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
    var body: some View {
        ZStack {
            Text(text.uppercased()).bold()
                .padding(6)
                .foregroundColor(.white)
                .font(.caption)
        }
        .cornerRadius(10.0)
//        .padding(6)
    }
}
struct SearchView: View {
    @State var input: String = ""
    @State var empty: String = ""
    
    @StateObject var searchVM : SearchVM = SearchVM()
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $input, onTextChanged: searchMovies)
                List {
                    if empty.isEmpty{
                        ForEach(searchVM.results) { movie in
                     
                            
                            GeometryReader { geometry in
                            KFImage(URL(string:  movie.backdrop_path ))
                                .resizable()
                                .frame(width: 375, height: 300)
                                .clipped()
                                .scaledToFill()
                                .overlay(ImageOverlay(text: movie.title), alignment: .bottomLeading)
                                .overlay(ImageOverlay(text: movie.media_type), alignment: .topLeading)
                                .overlay(ImageOverlay(text: movie.vote_average), alignment: .topTrailing)
                            }.frame(height: 300, alignment: .center)
                        }
                    }
                    else {
                        Text(empty)
                    }
                }
            }.navigationBarTitle(Text("Search"))
        }
    }
    func searchMovies(for input: String) {
        if !input.isEmpty && input.count > 3 {
            searchVM.load(query: input)
            if !searchVM.results.isEmpty {
                empty = "No Results"
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onTextChanged: (String) -> Void
    
    class Coordinator: NSObject, UISearchBarDelegate {
        var onTextChanged: (String) -> Void
        @Binding var text: String
        init(text: Binding<String>, onTextChanged: @escaping (String) -> Void) {
            _text = text
            self.onTextChanged = onTextChanged
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            onTextChanged(text)
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onTextChanged: onTextChanged)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(input: "mulan")
    }
}
