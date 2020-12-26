//
//  previewModels.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import Foundation

func createPreviewMessage(from: String, content: String, embed: Embed?, avatar: String?) -> AppMessage {
    return AppMessage(
        message: Message(
            content: content,
            embed: embed
        ),
        author: User(
            name: from,
            avatar: avatar ?? "https://cdn.miki.ai/ext/imgh/1dpSYfcAfy.gif",
            bot: false
        )
    );
}

func createPreviewChannel(name: String) -> AppChannel {
    return AppChannel(
        channel: Channel(
            id: "0",
            name: "Test"));
}
