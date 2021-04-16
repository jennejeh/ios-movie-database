//
//  NowPlaying.swift
//  hw9
//
//  Created by Jenny Jeh on 4/14/21.
//

import Foundation
import Alamofire
class NowPlaying: ObservableObject {
    func nowPlaying() {
                let url = "http://127.0.0.1:8080/nowplaying"

                Alamofire.request(url, method: .post)
                    .validate()
                    .responseJSON { resp in
                        if resp.result.isSuccess{
                            print(resp)
                        }
                           
    //                        let data = resp.result.value as? [String: Any],
    //                        let user = data["currentUser"] as? [String: String],
    //                        let users = data["users"] as? [String: [String: String]],
    //                        let id = user["id"], let name = user["name"]
                    }
            }



    
}

