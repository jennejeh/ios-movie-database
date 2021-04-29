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
    var cast : [castMember]
//    init (cast: [castMember]){
//        self.cast = cast
//    }
        var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView (.horizontal) {
                HStack(alignment: .top, spacing: 5){
                    ForEach(cast) {
                        c in
                            VStack{
                                KFImage(URL(string:  c.profile_path ))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipped()
                                    .clipShape(Circle())
                               
                                Text(c.name).frame(alignment: .center).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).font(.footnote)
                            } .frame(width: 90)
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
