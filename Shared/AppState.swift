//
//  AppState.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import Foundation

class AppState: ObservableObject {
    var channels: Dictionary<String, AppChannel>;
    var currentChannel: AppChannel?;

    init() {
        channels = Dictionary<String, AppChannel>();
        currentChannel = Optional.none;
    }
}

enum AppAction {
    case upsertChannel(channel: AppChannel)
    case switchChannel(channelId: String)
    case createMessage(message: Message)
}

typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch(action) {
    case .upsertChannel(let channel):
        state.channels.updateValue(channel, forKey: channel.Id);
    case .switchChannel(let channelId):
        state.currentChannel = state.channels[channelId];
    case .createMessage(let message):
        state.channels[message.ChannelId]?.Messages.append(message);
    }
}
