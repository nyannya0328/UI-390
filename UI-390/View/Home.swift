//
//  Home.swift
//  UI-390
//
//  Created by nyannyan0328 on 2021/12/11.
//

import SwiftUI

struct Home: View {
    @StateObject var model = HomeViewModel()
    var body: some View {
        
        
        VStack{
            
            
            HStack{
                
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 47, height: 47)
                
                Text("Discover")
                    .font(.largeTitle.bold())
                
            }
            .padding()
            .frame(maxWidth:.infinity,alignment: .leading)
            
            ZStack{
                
                if let users = model.displaying_users{
                    
                    
                    
                    if users.isEmpty{
                        
                       Image("User1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 250, height: 250)
                            .cornerRadius(10)
                    }
                    
                    else{
                        
                        ForEach(users.reversed()){user in
                            
                            
                            CardView(user: user)
                                .environmentObject(model)
                        }
                       
                        
                        
                        
                    }
                    
                }
                else{
                    
                ProgressView()
                }
                
                
                
            }
            .padding()
            .padding(.top,30)
            .padding(.vertical)
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            
            
            HStack(spacing:15){
                
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(13)
                        .background(Color("Gray").clipShape(Circle()))
                        .shadow(radius: 5)
                    
                    
                }
                
                Button {
                    
                doSwipe()
                    
                } label: {
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color("Blue").clipShape(Circle()))
                        .shadow(radius: 5)
                    
                    
                }
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(13)
                        .background(Color("Yellow").clipShape(Circle()))
                        .shadow(radius: 5)
                    
                    
                }
                
                Button {
                    
                    doSwipe(right: true)
                    
                } label: {
                    
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color("Pink").clipShape(Circle()))
                        .shadow(radius: 5)
                    
                    
                }

            }
            .padding(.bottom,8)
            .disabled(model.displaying_users?.isEmpty ?? false)
            .opacity(model.displaying_users?.isEmpty ?? false ? 0.6 : 1)
            
            
            
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
    }
    
    func doSwipe(right : Bool = false){
        
        
        guard let first = model.displaying_users?.first else {
            
            return
        
        }
        
        
        NotificationCenter.default.post(name: Notification.Name("ACTIONFROMBUTTON"), object: nil,userInfo: [
        
        
        
            "id" : first.id,
            "rightSwipe" : right
        
        ])
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
