//
//  MemorModel.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 11.12.2022.
//

import Foundation


struct MemoryGame <CardContent> where CardContent: Equatable{

    private(set) var cards : Array<Card>
    
    private var indexOfTheandOnlyFaceUpCard: Int?{
        get { cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set{cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue)} }
    }
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
              cards[choosenIndex].isFaceUp = true
          }else{
             
              indexOfTheandOnlyFaceUpCard = choosenIndex
          }
          
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
    
    
    mutating func shuffle (){
        cards.shuffle()
    }
    
    
    init(numberOfPairsOfCards: Int, creatCardContent: (Int) -> CardContent ) {
       cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = creatCardContent(pairIndex)
            cards.append(Card(content: content, id:pairIndex*2))
            cards.append(Card(content: content,id: pairIndex*2+1))
        }
        cards.shuffle()
        
    }
    
    struct Card: Identifiable {
        var isFaceUp = false{
            didSet{
                if isFaceUp{
                    startUsingTime()
                }else{
                    stopUsingTime()
                }
            }
        }
        var isMatched = false{
            didSet{
                stopUsingTime()
            }
        }
        let content: CardContent
        let id: Int
        
        
        
        var timeLimit:TimeInterval = 6
        
        private var faceUpTime: TimeInterval{
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }else
            {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var TimoRemainino: TimeInterval {max(0, timeLimit - faceUpTime)}

        var Remaining: Double {(timeLimit > 0 && TimoRemainino > 0) ? TimoRemainino/timeLimit:0 }
       
        var hasEarnedBonus: Bool{
            isMatched && Remaining > 0
        }
        
        var isConsumingTime:Bool{
            isFaceUp && !isMatched && TimoRemainino > 0
        }
        
        private mutating func startUsingTime(){
            if isConsumingTime,lastFaceUpDate == nil
            {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
        
        
    }
}

extension Array {
    
    var oneAndOnly: Element?{
        if count == 1 {
            return first
        }else{
            return nil
        }
    }
}
