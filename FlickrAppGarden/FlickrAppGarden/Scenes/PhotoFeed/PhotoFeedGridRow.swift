import SwiftUI
import SDWebImageSwiftUI

struct PhotoFeedGridRow: View {

    let imageURL: String

    var body: some View {
        AnimatedImage(url: URL(string: imageURL))
            .transition(.fade)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    PhotoFeedGridRow(imageURL: "https://live.staticflickr.com/65535/53400922704_6917718dfb_m.jpg")
}
