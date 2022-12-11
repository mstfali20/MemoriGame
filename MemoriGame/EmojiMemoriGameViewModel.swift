//
//  EmojiMemoriGameViewModel.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 12.12.2022.
//

import SwiftUI



class EmojiMemoriGame  {
    static let emojis = ["🐶","🐰","🦁","🐔","🐗","🐻‍❄️","🐷","🐸","🐌","🦎","🐢","🦑","🐡","🐟","🐬","🐞","🦂","🐜","🐴","🐝","🐣","🐵","🐙","🐳",]
    
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: 4){pairIndex in
            EmojiMemoriGame.emojis[pairIndex]
    }
    
    
        private var model:MemoryGame<String> =EmojiMemoriGame.createMemoryGame()
    
    var cards:Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
}
