//
//  CarouselView.swift
//  hw9
//
//  Created by Jenny Jeh on 4/15/21.
//

import SwiftUI
import Kingfisher
var filler3 = [review]()
struct ReviewView: View {
    let reviews: [review]
    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            ScrollView (.horizontal) {
//                HStack(alignment: .top, spacing: 16){
//
//                }
//            }
//        }
        ForEach(self.reviews) {
            r in
            VStack{
                Text(r.username)
                Text(r.created_at)
                Text(r.rating)
                Text(r.content)
            }
        }
        
    }
}
//
struct ReviewView_Previews: PreviewProvider {

    static var previews: some View {
        ReviewView(reviews: filler3)
    }
}
