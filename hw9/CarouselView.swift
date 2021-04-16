//
//  CarouselView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/15/21.
//

import SwiftUI
import Kingfisher

class TestViewModel: ObservableObject {

    init() {
        print("Init")
    }
    
}

struct CarouselView: View {
    
    let title: String
    let movies: [movie]
    
    @StateObject var tvm = TestViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.title).fontWeight(.bold).padding(.horizontal)
            ScrollView {
                GeometryReader { geometry in
                    ImageCarouselView(numberOfImages: 5) {
                        ForEach(self.movies) {
                            movie in
                            KFImage(URL(string:  movie.backdrop_path ))
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                        
                        }
                    }
                }.frame(height: 300, alignment: .center)
                
            }
            
        }
       
    }
}
//
struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(title: "Current", movies: currentmovies)
    }
}
