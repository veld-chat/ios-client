//
//  ApiRequestArgs.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 26/12/2020.
//

import Foundation

struct SendMessageRequest: Encodable {
    var content: String?;
    var embed: Embed?;
}
