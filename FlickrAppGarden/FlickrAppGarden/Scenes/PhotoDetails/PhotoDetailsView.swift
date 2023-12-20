import SwiftUI
import SDWebImageSwiftUI

struct PhotoDetailsView: View {

    @State var orientation = UIDevice.current.orientation

    let details: PhotoDetails

    var body: some View {
        List {
            Section() {
                AnimatedImage(url: URL(string: details.imageUrl ?? ""))
                    .resizable()
                    .frame(height: orientation.isPortrait ? 200 : 300)
                    .listRowInsets(EdgeInsets())
            }

            Section {
                Text(details.title)
            }

            informationsSection

            sizingSection

            Section(header: Text("Tags")) {
                Text(details.tags)
            }
        }
        .detectOrientation($orientation)
        .navigationTitle(details.title)
    }

    var informationsSection: some View {
        Section(header: Text("Informations")) {
            HStack {
                Text("Author")
                Spacer()
                Text(details.author)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Text("Published")
                Spacer()
                Text(details.published.toDate(with: .universal))
                    .foregroundStyle(.secondary)
            }
        }
    }

    var sizingSection: some View {
        Section(header: Text("Sizing")) {
            HStack {
                Text("Width")
                Spacer()
                Text(details.width)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Text("Height")
                Spacer()
                Text(details.height)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    PhotoDetailsView(
        details: .init(
            title: "Strike a Pose!",
            author: "Laura Macky",
            published: "2023-12-20T16:34:22Z",
            imageUrl: "https://live.staticflickr.com/65535/53409342642_84bdb6efcc_m.jpg",
            width: "240",
            height: "160",
            tags: "birds wildlife cedarwaxwing lauramacky"
        )
    )
}
