//
//  EmojiMemoriGameViewModel.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 12.12.2022.
//

import SwiftUI


/*"🐏","🦃","🐘","🦧","🐓","🐇","🐿️","🦔","🦘","🦒","🦍","🦅","🦉","🐧","🐭","🐧","🐼","🐨","🐯","🪲","🐍","🐡","🦞","🦀","🐠","🐬","🦗","🕷️","🦋","🪱","🐛","🐌","🦛","🐫","🐆","🦓","🦩","🦜","🦨","🦡","🦥"*/


class EmojiMemoriGame: ObservableObject  {
    static let emojis = ["🐶","🐰","🦁","🐔","🐗","🐻‍❄️","🐷","🐸","🐌","🦎","🐢","🦑","🐡","🐟","🐬","🐞","🦂","🐜","🐴","🐝","🐣","🐵","🐙","🐳",]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String> (numberOfPairsOfCards: 5) { pairIndex in
            emojis[pairIndex]
        }
    }
        
        
       @Published private var model: MemoryGame<String> = createMemoryGame()
        
        var cards: Array<MemoryGame<String>.Card> {
            return model.cards
        }
    

    
    //Mark: - Intent(s)
    
    
    func choose(_ card:MemoryGame<String>.Card){
        
        model.choose(card)
        
        
    }
    
    
    
    
}
