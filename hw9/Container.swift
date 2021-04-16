//
//  Container.swift
//  hw9
//
//  Created by Jenny Jeh on 4/15/21.
//

import SwiftUI

struct Container <Content : View> : View {
    var content : Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .cornerRadius(20)
       
    }
}

//struct Container_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        Container(content:"")
//    }
//}
