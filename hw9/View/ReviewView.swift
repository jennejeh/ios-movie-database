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
    let title : String
    var body: some View {
        //if (!self.reviews.isEmpty){
          //  Text("Reviews").font(.title).fontWeight(.bold)
        ScrollView {
            ForEach(self.reviews) {
                r in
                NavigationLink(destination: ReviewExtendView(review: r, title: self.title)){
                    LazyVStack(alignment: .leading, spacing: 5){
                        LazyVStack(alignment: .leading, spacing: 0){
                            Text("A review by " + r.username).font(.headline).fontWeight(.bold).frame(alignment: .leading).foregroundColor(Color.black)
                            Text("Written by " + r.username + " on " + r.created_at).frame(alignment: .leading).foregroundColor(Color.gray)
                            
                        }.padding(10)
                        
                      
                        HStack {
                            Image(systemName: "star.fill").foregroundColor(Color.red)
                            Text(r.rating).frame(alignment: .leading).foregroundColor(Color.black)
                        }
                   
                        Text(r.content).padding(10).frame(alignment: .leading).lineLimit(3).foregroundColor(Color.black)
                    }.frame(width: 350, alignment: .center).addBorder(Color.gray, width: 1, cornerRadius: 10)
                Spacer()
             
                    // EmptyView()
                }
            }
        }
      //  }
        
    }
}

struct ReviewExtendView: View {
    let review: review
    let title: String
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text(title).font(.title).fontWeight(.bold)
                Spacer()
                Text("By " + review.username + " on " + review.created_at).frame(alignment: .leading).foregroundColor(Color.gray)
                Spacer()
                HStack {
                    Image(systemName: "star.fill").foregroundColor(Color.red)
                    Text(review.rating).frame(alignment: .leading).foregroundColor(Color.black)
                }
                Spacer()
                Text(review.content).frame(alignment: .leading)
            }.padding()
            
        }
        
    }
}
extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
//
struct ReviewView_Previews: PreviewProvider {
    
    static var previews: some View {
        ReviewView(reviews: filler3, title: "Title")
    }
}

