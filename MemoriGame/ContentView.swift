//
//  ContentView.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 11.12.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewMdeol : EmojiMemoriGame
    var body: some View {

            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(viewMdeol.cards ){ card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewMdeol.choose(card)
                            }
                            
                    }
      
                }
            }.foregroundColor(.orange)
       .padding(.horizontal)
    }
        

}



struct CardView:View{
    let card: MemoryGame<String>.Card
    
    
  
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }else{
                shape.fill()
            }
        }
      
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
 */


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoriGame()
        ContentView(viewMdeol: game).preferredColorScheme(.dark)
        ContentView(viewMdeol: game).preferredColorScheme(.light)
    }
}
