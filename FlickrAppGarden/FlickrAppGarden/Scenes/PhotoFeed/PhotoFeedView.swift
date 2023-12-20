import SwiftUI

struct PhotoFeedView: View {

    @ObservedObject var viewState: PhotoFeedViewState
    let interactor: PhotoFeedInteractorProtocol

    var body: some View {
        ZStack {
            switch viewState.state {
            case .loading:
                ProgressView("Loading...")
            case .loaded:
                contentView
            case .error:
                Text("Whoops, There's an error")
            case .empty:
                EmptyView()
            }
        }
        .task {
            await interactor.fetchData(with: "birds")
        }
    }

    var contentView: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)], spacing: 3) {
                ForEach(0..<viewState.photos.count, id: \.self) { value in
                    PhotoFeedGridRow(imageURL: viewState.photos[value].media.imageURL ?? "")
                }
            }
        }
        .padding()
    }
}

#Preview {
    let viewState = PhotoFeedViewState()
    let presenter = PhotoFeedPresenter(viewState: viewState)
    let interactor = PhotoFeedInteractor(loader: .init(), presenter: presenter)

    return PhotoFeedView(viewState: viewState, interactor: interactor)
}
