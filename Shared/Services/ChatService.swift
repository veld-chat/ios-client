//
//  ChatService.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 26/12/2020.
//

import Foundation

class ChatService: ObservableObject {
    var store: AppStore;
    let baseUrl = "https://chat-gateway.veld.dev/";
    
    init(store: AppStore) {
        self.store = store;
    }
    
    func sendMessage(channelId: String, content: String?, embed: Embed?) {
        if(content == nil && embed == nil) {
            return;
        }
        
    
        guard let encoded = try? JSONEncoder()
                .encode(SendMessageRequest(content: content, embed: embed)) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "\(self.baseUrl)api/v1/channels/\(channelId)/messages")!
        var request = URLRequest(url: url);
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        request.setValue("Bearer \(store.state.session!.Token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST";
        request.httpBody = encoded;
        URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil) {
                print(error!)
                return;
            }
            print(response!);
        }.resume()
    }
}
