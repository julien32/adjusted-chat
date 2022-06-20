//
//  MessageView.swift
//  Chat
//
//  Created by Alex.M on 23.05.2022.
//

import SwiftUI

struct MessageView: View {
    let message: Message

    @Environment(\.messageParser) var messageParser

    var body: some View {
        MessageContainer(author: message.author) {
            VStack(alignment: .leading) {
                if !message.text.isEmpty {
                    messageParser.text(from: message.text)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                }

                if !message.attachments.isEmpty {
                    AttachmentsGrid(attachments: message.attachments)
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(
            message: Message(
                id: 0,
                author: .tim,
                text: "Example text"
            )
        )
        MessageView(
            message: Message(
                id: 0,
                author: .steve,
                text: "*Example* **markdown** _text_"
            )
        )
        .environment(\.messageParser, MarkdownExampleMessageParser())

        MessageView(
            message: Message(
                id: 0,
                author: .steve,
                attachments: [
                    ImageAttachment(
                        id: UUID().uuidString,
                        thumbnail: URL(string: "https://picsum.photos/200/300")!,
                        full: URL(string: "https://picsum.photos/200/300")!,
                        name: nil
                    )
                ]
            )
        )
    }
}
