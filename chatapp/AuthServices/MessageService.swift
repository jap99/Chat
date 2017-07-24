//
//  MessageService.swift
//  chatapp
//
//  Created by Javid Poornasir on 7/23/17.
//  Copyright © 2017 Javid Poornasir. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]() // our place to store channels
    var selectedChannel: Channel?
    
    
    // func to retrieve channels
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                // create json object out of the data
                guard let data = response.data else { return }
                
                //the swift 4 way
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error as Any)
//                }
                
                // turn our json data into an array
                if let json = JSON(data: data).array { // gives us an array of json objects

                    for item in json {
                        //parse out the individual properties of the array
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue

                        // instantiate and create a new channel object
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)

                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
}