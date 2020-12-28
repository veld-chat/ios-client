import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image: UIImage = UIImage()

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
