//
//  Cardify.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 13.12.2022.
//

import SwiftUI

struct Cardify: AnimatableModifier {
  
    var rotation : Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
        
    }
    
    var animatableData:Double{
        get{
            rotation
        }
        set{
           rotation = newValue
        }
    }
    
    func body (content: Content) -> some View{
      
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                content
            }
            else{
                shape.fill()
            }
            content.opacity(rotation<90 ? 1 : 0)
        }.rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth : CGFloat = 3
        static let fontScle : CGFloat = 0.7
    }
}

extension View{
    func cardfy(isFaceUp:Bool) -> some View {
        
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
