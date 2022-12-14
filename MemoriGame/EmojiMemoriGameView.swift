//
//  ContentView.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 11.12.2022.
//

import SwiftUI

struct EmojiMemoriGameView: View {
    @ObservedObject var game : EmojiMemoriGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment:.bottom){
            VStack{
                gameBody
               
                HStack{
                    restart
                    Spacer()
                    shuffle
                }.padding(.horizontal)
                
            }
            deckBody
        }
        
    .padding(.horizontal)
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoriGame.Card){
        dealt.insert(card.id)
        
    }
    private func isUndealt(_ card:EmojiMemoriGame.Card)-> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoriGame.Card) -> Animation {
    var delay = 0.0
        if let index = game.cards.firstIndex(where:  {$0.id == card.id }) {
    delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
    }
        return Animation.easeInOut (duration: CardConstants.dealDuration).delay (delay)
    
    }
    
    private func zIndex(of card:EmojiMemoriGame.Card)->Double{
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    var gameBody: some View{
            AspectVGrit(items:game.cards,aspectRatio:2/3,content:{ card in
                if (isUndealt(card) || (card.isMatched && !card.isFaceUp)){
                    Color.clear
                }else{
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .padding(4)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                        .zIndex(zIndex(of: card))
                        .onTapGesture {
                            withAnimation{
                                game.choose(card)
                            }
                        }
                }
               
            })
                .foregroundColor(.orange)
           
    }
    
    var deckBody:some View{
        ZStack{
            ForEach(game.cards.filter(isUndealt)){ card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                .zIndex(zIndex(of: card))

                
            }
        }.frame(width: CardConstants.undealtwidth,height: CardConstants.undealtHeight)
            .foregroundColor(CardConstants.color)
            .onTapGesture{
               
                    for card in game.cards{
                        withAnimation(dealAnimation(for: card)){
                        deal(card)
                    }
                }
            }
        
    }
    
    var shuffle: some View{
        Button("Shuffle")
        {
            withAnimation{
                game.shuffle()
            }
        }
    }

    
    var restart: some View{
        Button("Restart") {
            withAnimation{
                dealt = []
                game.restart()
            }
            
        }
    }

    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtwidth = undealtHeight * aspectRatio
        
    }
    
}
struct CardView:View{
    let card: EmojiMemoriGame.Card
    @State private var animatedRemaining: Double = 0
    
    var body: some View{
       GeometryReader(content: {geometry in
           ZStack{
               if card.isConsumingTime{
                   Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedRemaining)*360-90)).padding(5).opacity(0.5)
                       .onAppear{
                           animatedRemaining = card.Remaining
                           withAnimation(.linear(duration: card.TimoRemainino)){
                               animatedRemaining = 0
                           }
                       }

               }else{
                   Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.Remaining)*360-90)).padding(5).opacity(0.5)

               }
                 
                   Text(card.content)
                       .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                       .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                       .font(Font.system(size: DrawingConstants.fontSize))
                       .scaleEffect(scale(thatFits:geometry.size))
               
           }
           .cardfy(isFaceUp: card.isFaceUp)
           
           
       })
      
    }
    
    private func scale(thatFits size :CGSize) -> CGFloat{
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScle)
    }
    
    
    private func font(in size: CGSize)-> Font{
        Font.system(size: min(size.height, size.width) * DrawingConstants.fontScle)
    }
    
    
    
    private struct DrawingConstants {
      //  static let cornerRadius: CGFloat = 10
       // static let lineWidth : CGFloat = 3
        static let fontScle : CGFloat = 0.7
        static let fontSize : CGFloat = 32
    }
}






/*
 var add: some View{
     Button{
         if emojiCaut < emojis.count {
             emojiCaut += 1
         }
        
     }
 label:{ VStack{
         Image(systemName: "plus.circle.fill")
     }}
 }
 
 var remote: some View {
     Button{ if emojiCaut > 1 {
         emojiCaut -= 1 }
     }
 label:{ VStack{
         Image(systemName: "minus.circle.fill")
     }}
     
 }
 
 
 
 
 ZStack{
     let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
     if card.isFaceUp {
         shape.fill().foregroundColor(.white)
         shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
         Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(5).opacity(0.5)
         Text(card.content)
             .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
             .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
             .font(Font.system(size: DrawingConstants.fontSize))
             .scaleEffect(scale(thatFits:geometry.size))
     }else if card.isMatched{
         shape.opacity(0)
     }
     else{
         shape.fill()
     }
 }
 
 */


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoriGame()
     // game.choose(game.cards.first!)
       //return EmojiMemoriGameView(game: game).preferredColorScheme(.dark)
        EmojiMemoriGameView(game: game).preferredColorScheme(.dark)
    }
}
