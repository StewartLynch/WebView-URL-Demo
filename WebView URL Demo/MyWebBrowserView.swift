//
//----------------------------------------------
// Original project: WebView URL Demo
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
import WebKit

struct MyWebBrowserView: View {
    @State private var urlString = ""
    @State private var url: URL?
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    TextField(text: $urlString) {
                        Text("\(Image(systemName: "magnifyingglass")) Enter Web Site...")
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .submitLabel(.go)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .keyboardType(.URL)
                    .onSubmit {
                        url = URL(string: urlString)
                    }
                    if !urlString.isEmpty {
                        Button {
                            urlString = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding(.horizontal)
                WebView(url: url)
                    .ignoresSafeArea(edges: .bottom)
            }
            .navigationTitle("My Web Browser")
        }
    }
}
#Preview {
    MyWebBrowserView()
}

