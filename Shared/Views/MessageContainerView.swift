//
//  MessageView.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import SwiftUI

struct MessageContainerView: View {
    @EnvironmentObject var store: AppStore;
    @EnvironmentObject var chatService: ChatService;
    
    var body: some View {
        guard let channel = store.state.currentChannel else {
            return AnyView(Text("No channel selected"));
        }
        
        return AnyView(
            VStack(alignment: .leading) {
                Group {
                    HStack {
                        Text("")
                            .font(.custom("FontAwesome5Free-Solid", size: 16))
                            .padding(.trailing, 4.0);
                        Text(channel.getName())
                            .lineLimit(1)
                            .frame(
                                maxWidth: .greatestFiniteMagnitude,
                                alignment: .topLeading
                            );
                    }.padding(.all, 16.0);
                    Divider();
                };
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach(channel.getMessages()) { message in
                        MessageView(message: message)
                            .frame(
                                maxWidth: .greatestFiniteMagnitude,
                                alignment: .topLeading
                            )
                    }.frame(
                        maxWidth: .greatestFiniteMagnitude
                    )
                }
                .frame(maxWidth: .greatestFiniteMagnitude)
                Spacer();
                MessageBarView()
                    .environmentObject(store)
                    .environmentObject(chatService)
            }
        )
    }
}

struct MessageContainerView_Previews: PreviewProvider {
    static var previews: some View {
        let state = AppState();
        let store = AppStore(initialState: state, reducer: appReducer);
        
        let channel = createPreviewChannel(name: "Test");
        channel.addMessage(
            message: createPreviewMessage(
                from: "Veld",
                content: "Hello World!",
                embed: nil,
                avatar: nil));
        channel.addMessage(
            message: createPreviewMessage(
                from: "Veld",
                content: "Hello World! AAAAAAAAAA",
                embed: nil,
                avatar: "https://cdn.miki.ai/ext/imgh/12EyWVCv4c1.png"));

        store.dispatch(AppAction.upsertChannel(channel: channel));
        store.dispatch(AppAction.switchChannel(channelId: channel.getId()));
        
        return AnyView(
            MessageContainerView()
                .environmentObject(store)
        );
    }
}
