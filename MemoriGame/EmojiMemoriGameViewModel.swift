//
//  EmojiMemoriGameViewModel.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 12.12.2022.
//

import SwiftUI


/*"🐏","🦃","🐘","🦧","🐓","🐇","🐿️","🦔","🦘","🦒","🦍","🦅","🦉","🐧","🐭","🐧","🐼","🐨","🐯","🪲","🐍","🐡","🦞","🦀","🐠","🐬","🦗","🕷️","🦋","🪱","🐛","🐌","🦛","🐫","🐆","🦓","🦩","🦜","🦨","🦡","🦥"*/


class EmojiMemoriGame: ObservableObject  {
    typealias Card = MemoryGame<String>.Card
   private static let emojis = ["🐶","🐰","🦁","🐔","🐗","🐻‍❄️","🐷","🐸","🐌","🦎","🐢","🦑","🐡","🐟","🐬","🐞","🦂","🐜","🐴","🐝","🐣","🐵","🐙","🐳",]
    
   private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String> (numberOfPairsOfCards: 6) { pairIndex in
            emojis[pairIndex]
        }
    }
        
        
       @Published private var model: MemoryGame<String> = createMemoryGame()
        
        var cards: Array<Card> {
             model.cards
        }
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoriGame.createMemoryGame()
    }
    
    
}
