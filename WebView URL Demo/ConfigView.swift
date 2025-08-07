//
//----------------------------------------------
// Original project: Webview URL Dev
// by  Stewart Lynch on 2025-08-06
//
// Follow me on Mastodon: https://iosdev.space/@StewartLynch
// Follow me on Threads: https://www.threads.net/@stewartlynch
// Follow me on Bluesky: https://bsky.app/profile/stewartlynch.bsky.social
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Email: slynch@createchsol.com
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2025 CreaTECH Solutions. All rights reserved.


import SwiftUI

struct ConfigView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var config: Config
    var body: some View {
        NavigationStack {
            Form {
                Toggle("Back and Foward Navigation", isOn: $config.navActions)
                Toggle("Magnification Gestures", isOn: $config.magnification)
                Toggle("Weblink Previews", isOn: $config.linkPreviews)
                Toggle("Text Selection", isOn: $config.textSelection)
            }
            .navigationTitle("WebView Configuration")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") { dismiss() }
                }
            }
        }

    }
}

#Preview {
    @Previewable @State var config = Config()
    ConfigView(config: $config)
}

struct Config {
    var navActions = false
    var magnification = false
    var linkPreviews = false
    var textSelection = false
}

