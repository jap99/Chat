//
//  UserDataService.swift
//  chatapp
//
//  Created by Javid Poornasir on 7/19/17.
//  Copyright © 2017 Javid Poornasir. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    // Create a public getter variable that other classes are able to get
    // It's private because other classes cannot set the var
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        
        self.avatarName = avatarName
    }
    
    
    
}
