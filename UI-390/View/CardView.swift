//
//  CardView.swift
//  UI-390
//
//  Created by nyannyan0328 on 2021/12/11.
//

import SwiftUI

struct CardView: View {
    var user : User
    @EnvironmentObject var model : HomeViewModel
    
    @State var offset : CGFloat = 0
    @GestureState var isDragging : Bool = false
    @State var finish : Bool = false
    var body: some View {
        GeometryReader{proxy in
            
            
            let size = proxy.size
            let index = CGFloat(model.getIndex(user: user))
            
            let topOffset = (index <= 2 ? index : 2) * 15
            
            ZStack{
                
                
                Image(user.Profile)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(10)
                    .offset(y: -topOffset)
                
                
                
                
                
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            
            
            
            
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angel: 8)))
        .contentShape(Rectangle().trim(from: 0, to: finish ? 0 : 1))
        .gesture(
        
        
            DragGesture().updating($isDragging, body: { _, out, _ in
                out = true
            })
                .onChanged({ value in
                    
                    let translation = value.translation.width
                    
                    offset = (isDragging ? translation : .zero)
                    
                })
                .onEnded({ value in
                    
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    
                    let checkStatus = (translation > 0 ? translation : -translation)
                    
                    
                    if checkStatus > (width / 2){
                        
                        
                        
                        offset = (translation > 0 ? width : -width) * 2
                        
                        
                        endSwipActions()
                        
                        if translation > 0{rightSwip()}
                        
                        else{leftSwip()}
                        
                        
                    }
                    
                    else{
                        
                        offset = .zero
                    }
                    
                    
                    
                    
                })
        
        
        
        
        
        
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            
            guard let info = data.userInfo else{return}
            
            let id = info["id"] as? String ?? ""
            
            let rigthSwip = info["rightSwipe"] as? Bool ?? false
            
            let widht = getRect().width - 50
            
            
            if user.id == id{
                
                withAnimation{
                    
                    
                    offset = (rigthSwip ? widht : -widht)
                    
                    
                }
                
                endSwipActions()
                
                
               
                
                if rigthSwip{
                    
                    self.rightSwip()
                }
                
                else{leftSwip()}
                
                
                
                
            }
            
            
            
        }
        
    }
    
    func getRotation(angel : Double) -> Double{
        
        let rotation = (offset / (getRect().width - 50) * angel)
        
        return rotation
        
        
    }
    
    func endSwipActions(){
        
        withAnimation(.none){finish = true}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            
            if let _ = model.displaying_users?.first{
                
                let _ = withAnimation{
                    
                    model.displaying_users?.removeFirst()
                    
                }
                
            }
            
            
        }
        
        
        
    }
    
    
    func rightSwip(){
        
        
    }
    
    func leftSwip(){
        
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}
