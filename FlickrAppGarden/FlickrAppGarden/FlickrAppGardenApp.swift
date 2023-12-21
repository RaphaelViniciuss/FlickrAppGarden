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
        let feedFactory = PhotoFeedFactory()
        let network = NetworkService()
        return feedFactory.make(networkService: network)
    }
}
