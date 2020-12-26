//
//  MessageBarView.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 26/12/2020.
//

import SwiftUI

struct MessageBarView: View {
    @EnvironmentObject var store: AppStore;
    @EnvironmentObject var chatService: ChatService;
    @State private var inputData = "";

    var body: some View {
        Group {
            Divider();
            HStack {
                TextField("Join the conversation", text: $inputData)
                    .padding(.all, 16.0);
                Button(action: sendMessage) {
                    Text("")
                        .font(
                            .custom("FontAwesome5Free-Solid", size: 16)
                        )
                }.padding(.all, 16.0)
            }.padding(.horizontal, 16.0)
        }
    }
    
    func sendMessage() {
        guard let channel = store.state.currentChannel else {
            return;
        }
        
        chatService.sendMessage(channelId: channel.getId(),
                                content: inputData,
                                embed: nil);
        inputData = "";
    }
}

struct MessageBarView_Previews: PreviewProvider {
    static var previews: some View {
        MessageBarView()
    }
}
