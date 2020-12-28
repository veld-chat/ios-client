//
//  chatApp.swift
//  Shared
//
//  Created by Mike  Veldsink on 25/12/2020.
//
//

import SwiftUI
import SocketIO

@main
struct chatApp: App {
    var store = AppStore(
        initialState: AppState(),
        reducer: appReducer);
    let socket: Socket;
    let chatService: ChatService;

    init() {
        socket = Socket(store: store);
        chatService = ChatService(store: store);
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(chatService)
        }
    }
}
