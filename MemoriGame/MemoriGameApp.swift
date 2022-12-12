//
//  MemoriGameApp.swift
//  MemoriGame
//
//  Created by Mustafa Ali KILCI on 11.12.2022.
//

import SwiftUI

@main
struct MemoriGameApp: App {
    let game = EmojiMemoriGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewMdeol: game)
        }
    }
}
