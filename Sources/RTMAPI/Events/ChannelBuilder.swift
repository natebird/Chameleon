//
//  ChannelBuilder.swift
//  Chameleon
//
//  Created by Ian Keen on 20/07/2016.
//
//

import Models

private enum ChannelEvent: String, RTMAPIEventBuilderEventType {
    case
    channel_marked, channel_created, channel_joined, channel_left,
    channel_deleted, channel_archive, channel_unarchive
    
    static var all: [ChannelEvent] {
        return [.channel_marked, .channel_created, .channel_joined, .channel_left,
                .channel_deleted, .channel_archive, .channel_unarchive]
    }
}

/// Handler for the channel events
struct ChannelBuilder: RTMAPIEventBuilder {
    static var eventTypes: [String] { return ChannelEvent.all.map({ $0.rawValue }) }
    
    static func make(withJson json: [String: Any], builderFactory: (json: [String: Any]) -> SlackModelBuilder) throws -> RTMAPIEvent {
        guard let event = ChannelEvent.eventType(fromJson: json)
            else { throw RTMAPIEventBuilderError.invalidBuilder(builder: self) }
        
        let builder = builderFactory(json: json)
        
        switch event {
        case .channel_marked:
            return .channel_marked(
                channel: try builder.lookup("channel"),
                timestamp: try builder.property("ts")
            )
        case .channel_created:
            return .channel_created(channel: try builder.model("channel"))
        case .channel_joined:
            return .channel_joined(channel: try builder.model("channel"))
        case .channel_left:
            return .channel_left(channel: try builder.lookup("channel"))
        case .channel_deleted:
            return .channel_deleted(channel: try builder.lookup("channel"))
        case .channel_archive:
            return .channel_archive(
                channel: try builder.lookup("channel"),
                user: try builder.lookup("user")
            )
        case .channel_unarchive:
            return .channel_archive(
                channel: try builder.lookup("channel"),
                user: try builder.lookup("user")
            )
        }
    }
}
