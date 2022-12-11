//
//  ContentView.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 11.12.2022.
//

import SwiftUI

struct ContentView: View {
var emojis = ["🐶","🐰","🦁","🐔","🐗","🐻‍❄️","🐷","🐸","🐌","🦎","🐢","🦑","🐡","🐟","🐬","🐞","🦂","🐜","🐴","🐝","🐣","🐵","🐙","🐳",]
    
    /*"🐏","🦃","🐘","🦧","🐓","🐇","🐿️","🦔","🦘","🦒","🦍","🦅","🦉","🐧","🐭","🐧","🐼","🐨","🐯","🪲","🐍","🐡","🦞","🦀","🐠","🐬","🦗","🕷️","🦋","🪱","🐛","🐌","🦛","🐫","🐆","🦓","🦩","🦜","🦨","🦡","🦥"*/
    
    
  @State var emojiCaut = 24
    var body: some View {
VStack
        {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(emojis[0..<emojiCaut],id: \.self){emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }  .foregroundColor(.red)
      
                }
            }
            Spacer()
            HStack{
                remote
                Spacer()
                add
                
            }.font(.largeTitle)
                .padding(.horizontal)
        }
       .padding(.horizontal)
       .foregroundColor(.orange)
          
        
    }
   
    
    
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
}



struct CardView:View{
    @State var acıkKapalı: Bool = true
    var content : String
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if acıkKapalı {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }else{
                shape.fill()
            }
        }
        .onTapGesture {
            acıkKapalı = !acıkKapalı
        }
    }
}

































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
        ContentView().preferredColorScheme(.light)
    }
}
