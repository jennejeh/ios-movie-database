//
//  CarouselView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/15/21.
//

import SwiftUI
import Kingfisher
var filler2 = [castMember]()
struct CastView: View {
    let cast: [castMember]
    init (cast: [castMember]){
        self.cast = cast
    }
        var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView (.horizontal) {
                HStack(alignment: .top, spacing: 16){
                    ForEach(self.cast) {
                        c in
                        VStack{
                            KFImage(URL(string:  c.profile_path ))
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipped()
                            Text(c.name)
                        }
                    }
                }
            }
        }
        
    }
}
//
struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(cast: filler2)
    }
}
