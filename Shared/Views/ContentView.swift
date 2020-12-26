//
//  ContentView.swift
//  Shared
//
//  Created by Mike  Veldsink on 25/12/2020.
//
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: AppStore;
    @EnvironmentObject var chatService: ChatService;
    
    var body: some View {
        MessageContainerView()
            .environmentObject(store)
            .environmentObject(chatService)
    }
}
