//
//  Socket.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import Foundation
import SocketIO

class Socket {
    var manager = SocketManager(
        socketURL: URL(string: "https://chat-gateway.veld.dev")!,
        config: [.log(true), .compress]);
    var socket: SocketIOClient;
    var store: AppStore;

    init(store: AppStore) {
        self.socket = manager.defaultSocket;
        self.store = store;
        
        socket.on(clientEvent: .connect) {data, ack in
            self.socket.emit("login", LoginArgs(token: Optional.none).socketRepresentation())
        };
        
        socket.on("ready", callback: ready);
        socket.on("message:create", callback: createMessage);
        
        socket.on("user:join", callback: userJoin);
        socket.on("user:leave", callback: userLeave);
        
        socket.connect();
    }
    
    func ready(data: [Any], ack: Any) {
        guard let readyPayload = data[0] as? [String: Any] else {
            return;
        }
        let ready = ReadyArgs(payload: readyPayload);
        store.dispatch(AppAction.updateSession(
            session: Session(Token: ready.token, CurrentUser: ready.currentUser.Id)));
        store.dispatch(AppAction.createUser(user: ready.currentUser));
        
        for channel in ready.channels {
            print("creating channel \(channel)")
            store.dispatch(AppAction.upsertChannel(channel: AppChannel(channel: channel)));
        }
        
        for member in ready.members {
            print("creating user \(member.Id)")
            store.dispatch(AppAction.createUser(user: member));
        }
    
        store.dispatch(AppAction.switchChannel(channelId: ready.mainChannel));
    }
    
    func createMessage(data: [Any], ack: Any) {
        guard let messagePayload = data[0] as? [String: Any] else {
            print("Cannot parse message payload");
            return;
        }
        
        let message = Message(payload: messagePayload)
        let author = store.state.members[message.user];
        if(author == nil) {
            print("user '\(message.user)' not found in cache.");
            print("user cache: \(store.state.members)")
            return;
        }
        
        store.dispatch(
            AppAction.createMessage(
                message: AppMessage(
                    message: message,
                    author: author!)));
    }
    
    func userJoin(data: [Any], ack: Any) {
        guard let userPayload = data[0] as? [String: Any] else {
            print("Cannot parse message payload");
            return;
        }
        store.dispatch(AppAction.createUser(user: User(payload: userPayload)));
    }
    
    func userLeave(data: [Any], ack: Any) {
        guard let userPayload = data[0] as? [String: Any] else {
            print("Cannot parse message payload");
            return;
        }
        
        store.dispatch(AppAction.deleteUser(userId: userPayload["id"] as! String))
    }
}
