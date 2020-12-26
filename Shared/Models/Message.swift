//
//  Message.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import Foundation

struct EmbedAuthor: Encodable {
    
}

struct Embed: Encodable {
    var Title: String?;
    var Description: String?;
    
    init(payload: [String: Any]) {
        
    }
}

struct Message {
    var id: String;
    var content: String?;
    var embed: Embed?;
    var user: String;
    var channelId: String;
    
    init(content: String, embed: Embed?) {
        self.content = content;
        self.embed = embed;
        
        id = "0";
        user = "0";
        channelId = "0";
    }
    init(payload: [String: Any]) {
        id = payload["id"] as! String;
        content = payload["content"] as! String?;
        embed = (payload["embed"] != nil)
            ? Embed(payload: payload["embed"] as! [String: Any])
            : Optional.none;
        user = payload["user"] as! String;
        channelId = payload["channelId"] as! String;
    }
}

class AppMessage: Identifiable {
    private var message: Message;
    private var author: User
    
    var id: ObjectIdentifier {
        get { return ObjectIdentifier(self) }
    }
    
    init(message: Message, author: User) {
        self.message = message;
        self.author = author;
    }
    
    func getAuthor() -> User {
        return author;
    }
    
    func getId() -> String {
        return message.id
    }
    
    func getChannelId() -> String {
        return message.channelId
    }
    
    func getContent() -> String? {
        return message.content
    }
    
    func getEmbed() -> Embed? {
        return message.embed
    }
}
