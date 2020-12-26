//
//  SocketPayloads.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import Foundation
import SocketIO

struct LoginArgs: SocketData {
    var token: String?;
    
    func socketRepresentation() -> SocketData {
        return ["token": token]
    }
}

struct ReadyArgs {
    var token: String;
    var channels: [Channel];
    var members: [User];
    var mainChannel: String;
    var currentUser: User;
    
    init(payload: [String: Any]) {
        token = payload["token"] as! String;
        channels = (payload["channels"] as! [[String: Any]]).map { Channel(payload: $0) }
        members = (payload["members"] as! [[String: Any]]).map { User(payload: $0) }
        mainChannel = payload["mainChannel"] as! String;
        currentUser = User(payload: (payload["user"] as! [String: Any]))
    }
}
