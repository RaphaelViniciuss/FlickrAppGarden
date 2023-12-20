//
//  FlickrAppGardenApp.swift
//  FlickrAppGarden
//
//  Created by Raphael Vinicius on 20/12/23.
//

import SwiftUI

@main
struct FlickrAppGardenApp: App {
    var body: some Scene {
        WindowGroup {
            feedView
        }
    }

    var feedView: some View {
        let viewState = PhotoFeedViewState()
        let presenter = PhotoFeedPresenter(viewState: viewState)
        let interactor = PhotoFeedInteractor(loader: .init(), presenter: presenter)
        return PhotoFeedView(viewState: viewState, interactor: interactor)
    }
}
