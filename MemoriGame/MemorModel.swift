//
//  MemorModel.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 11.12.2022.
//

import Foundation


struct MemoryGame <CardContent> where CardContent: Equatable {
    private(set) var cards : Array<Card>
    
    private var indexOfTheandOnlyFaceUpCard: Int?
    
    
  mutating func choose (_ card: Card){
      if let choosenIndex = cards.firstIndex(where: {$0.id == card.id}),
         !cards[choosenIndex].isFaceUp,
         !cards[choosenIndex].isMatched
      {
          if let potantialMatchIndex = indexOfTheandOnlyFaceUpCard{
              if cards[choosenIndex].content == cards[potantialMatchIndex].content{
              
                  cards[choosenIndex].isMatched = true
                 
                  cards[potantialMatchIndex].isMatched = true
              }
              indexOfTheandOnlyFaceUpCard = nil
          }else{
              for index in cards.indices{
                  cards[index].isFaceUp = false
              }
              indexOfTheandOnlyFaceUpCard = choosenIndex
          }
          cards[choosenIndex].isFaceUp.toggle()
      }
      
    }
    
    func index(of card: Card) -> Int{
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index
            }
        }
        
        return 0
    }
    
    init(numberOfPairsOfCards: Int, creatCardContent: (Int) -> CardContent ) {
       cards = Array <Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = creatCardContent(pairIndex)
            cards.append(Card(content: content, id:pairIndex*2))
            cards.append(Card(content: content,id: pairIndex*2+1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp:Bool = false
        var isMatched:Bool = false
        var content: CardContent
        var id: Int
    }
}
