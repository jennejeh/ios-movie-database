//
//  DetailVM.swift
//  hw9
//
//  Created by Jenny Jeh on 4/17/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class DetailVM2: ObservableObject{
    @Published var fetched = false
    @Published var movie = Movie()
    @Published var cast: [castMember] = []
    @Published var reviews = [review]()
    @Published var recommendedshows = [Movie]()
    //    init(){
    //        
    //    }
    func load(id: Int) {
        
        let parameters: Parameters = [
            "id": id
        ]

        
     
    }
    
}
