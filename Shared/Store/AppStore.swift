//
//  AppStore.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import Foundation

struct AppState {
    var channels: Dictionary<String, AppChannel>;
    var currentChannel: AppChannel?;
    var members: Dictionary<String, User>;
    var session: Session?;
    
    init() {
        channels = Dictionary<String, AppChannel>();
        currentChannel = nil;
        members = Dictionary<String, User>();
        session = nil;
    }
}

enum AppAction {
    case upsertChannel(channel: AppChannel)
    case switchChannel(channelId: String)
    
    case createMessage(message: AppMessage)
    
    case createUser(user: User)
    case deleteUser(userId: String)
    
    case updateSession(session: Session)
}

typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch(action) {
    case .upsertChannel(let channel):
        state.channels.updateValue(channel, forKey: channel.getId());
    case .switchChannel(let channelId):
        print(channelId);
        print(state.channels);
        state.currentChannel = state.channels[channelId];
        print("Current channel: \(String(describing: state.currentChannel))");
    case .createMessage(let message):
        let channel = state.channels[message.getChannelId()];
        if(channel == nil) {
            print("channel for message \(message) not found.");
        }
        channel?.addMessage(message: message);
    case .createUser(let user):
        state.members.updateValue(user, forKey: user.Id)
    case .deleteUser(let userId):
        state.members.removeValue(forKey: userId)
    case .updateSession(let session):
        state.session = session;
    }
}

typealias AppStore = Store<AppState, AppAction>
final class Store<State, Action>: ObservableObject {

    // Read-only access to app state
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>

    init(initialState: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    // The dispatch function.
    func dispatch(_ action: Action) {
        reducer(&state, action)
    }
}
