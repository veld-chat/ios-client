//
//  Channel.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import Foundation

struct UserStatus {
    var StatusText: String?;
    var Value: String;
}

struct User {
    var Id: String;
    var Name: String;
    var AvatarUrl: String?;
    var Bot: Bool;
    var Status: UserStatus;
    
    init(name: String, avatar: String, bot: Bool?) {
        Name = name;
        AvatarUrl = avatar;
        Bot = bot ?? false;
        Status = UserStatus(StatusText: nil, Value: "test");
        Id = "0";
    }
    init(payload: [String: Any]) {
        Id = payload["id"] as! String;
        Name = payload["name"] as! String;
        Bot = payload["bot"] as! Bool;
        AvatarUrl = payload["avatarUrl"] as! String?;
        Status = UserStatus(Value: "");
    }
}

struct Channel {
    var id: String;
    var system: Bool;
    var name: String;
    var members: [User];
    
    init(id: String, name: String) {
        self.id = id;
        self.name = name;
        system = false;
        members = [];
    }
    init(payload: [String: Any]) {
        id = payload["id"] as! String;
        system = payload["system"] as! Bool;
        name = payload["name"] as! String;
        members = (payload["members"] as! [[String: Any]]).map { User(payload: $0) };
    }
}

class AppChannel: ObservableObject {
    private var channel: Channel;
    private var members: [User];
    private var messages: [AppMessage];
    
    init(channel: Channel) {
        self.channel = channel;
        members = [];
        messages = [];
    }
    
    func getId() -> String {
        return channel.id;
    }
    
    func getName() -> String {
        return channel.name;
    }
    
    func addMessage(message: AppMessage) {
        self.messages.append(message);
        print("added message \(message.getId()) for channel \(getId())")
        print(self.messages.count);
    }
    
    func getMessages() -> [AppMessage] {
        return messages;
    }
}
