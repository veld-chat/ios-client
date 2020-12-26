//
//  MessageView.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 25/12/2020.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    var width: CGFloat?;
    var height: CGFloat?;
    
    init(withURL url:String, width: CGFloat?, height: CGFloat?) {
        imageLoader = ImageLoader(urlString:url)
        self.width = width;
        self.height = height;
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width ?? .none, height: height ?? .none)
            .clipShape(Circle())
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}

struct MessageView: View {
    var message: AppMessage;
    
    init(message: AppMessage) {
        self.message = message;
    }
    
    var body: some View {
        HStack(alignment: .top) {
            ImageView(
                withURL: message.getAuthor().AvatarUrl!,
                width: 48,
                height: 48)
                .padding(.trailing, 16.0)
                .frame(width: 48, height: 48, alignment: .topLeading)
            VStack(alignment: .leading) {
                Text(message.getAuthor().Name)
                    .font(.system(size: 16))
                    .bold()
                    .frame(alignment: .topLeading)
                Text(message.getContent() ?? "")
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        return MessageView(
            message: createPreviewMessage(
                from: "Veld",
                content: "Hello World!",
                embed: nil,
                avatar: nil));
    }
}
