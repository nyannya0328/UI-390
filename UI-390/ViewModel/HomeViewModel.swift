//
//  HomeViewModel.swift
//  UI-390
//
//  Created by nyannyan0328 on 2021/12/11.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var fetched_users : [User] = []
    
    @Published var displaying_users : [User]?
    
    init() {
        
        fetched_users = [
        
            
            User(Profile: "User1"),
            User(Profile: "User2"),
            User(Profile: "User3"),
            User(Profile: "User4"),
            User(Profile: "User5"),
            User(Profile: "User6"),
        
        
        
        ]
        
        displaying_users = fetched_users
        
    }
    
    func getIndex(user : User)->Int{
        
        let index = displaying_users?.firstIndex(where: { currentUser in
          
            return user.id == currentUser.id
        }) ?? 0
        
        return index
    }
}
