//
//  MemorModel.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 11.12.2022.
//

import Foundation


struct MemoryGame <CardContent> {
    private(set) var cards : Array<Card>
    
    var carts: Array<Card>
    
    func choose (_ card:Card){
        
    }
    
    init(numberOfPairsOfCards: Int, creatContent: (Int) -> CardContent ) {
       cards = Array <Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = creatContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
    }
    
    struct Card {
        var isFaceUp:Bool = false
        var isMatched:Bool = false
        var content: CardContent
    }
}
