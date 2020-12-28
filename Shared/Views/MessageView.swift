//
//  MessageView.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import SwiftUI

struct MessageView: View {
    var message: AppMessage;
    
    init(message: AppMessage) {
        self.message = message;
    }
    
    var body: some View {
        HStack(alignment: .top) {
            ImageView(
                withURL: message.getAuthor().AvatarUrl!,
                width: 48,
                height: 48)
                .padding(.trailing, 16.0)
                .frame(width: 48, height: 48, alignment: .topLeading)
            VStack(alignment: .leading) {
                Text(message.getAuthor().Name)
                    .font(.system(size: 16))
                    .bold()
                    .frame(alignment: .topLeading)
                Text(message.getContent() ?? "")
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        return MessageView(
            message: createPreviewMessage(
                from: "Veld",
                content: "Hello World!",
                embed: nil,
                avatar: nil));
    }
}
