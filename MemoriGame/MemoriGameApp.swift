//
//  MemoriGameApp.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 11.12.2022.
//

import SwiftUI

@main
struct MemoriGameApp: App {
   private let game = EmojiMemoriGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoriGameView(game: game)
        }
    }
}
