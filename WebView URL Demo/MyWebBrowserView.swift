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
    @State private var isReachable = false
    @State private var showConfig = false
    @State private var config = Config()
    @Namespace private var configSpace
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
                        Task {
                            await checkAvailability()
                        }
                    }
                    if !urlString.isEmpty {
                        Button {
                            urlString = ""
                            Task {
                                await checkAvailability()
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding(.horizontal)
                if isReachable {
                    WebView(url: url)
                        .ignoresSafeArea(edges: .bottom)
                        .scrollBounceBehavior(.basedOnSize)
                        .webViewBackForwardNavigationGestures(config.navActions ? .enabled : .disabled)
                        .webViewMagnificationGestures(config.magnification ? .enabled : .disabled)
                        .webViewLinkPreviews(config.linkPreviews ? .enabled : .disabled)
                        .webViewTextSelection(config.textSelection)
                } else {
                    ContentUnavailableView("Enter a valid URL", systemImage: "link")
                }
            }
            .navigationTitle("My Web Browser")
            .task {
                await checkAvailability()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Configuration", systemImage: "gear") {
                        showConfig.toggle()
                    }
                }
                .matchedTransitionSource(id: "config", in: configSpace)
            }
            .sheet(isPresented: $showConfig) {
                ConfigView(config: $config)
                    .presentationDetents([.medium])
                    .navigationTransition(.zoom(sourceID: "config", in: configSpace))
            }
        }
    }
    
    func checkAvailability() async {
        if !urlString.hasPrefix("https://") {
            urlString = "https://".appending(urlString)
        }
        isReachable = await Reachability.checkURL(urlString)
        if isReachable {
            url = URL(string: urlString)
        } else {
            urlString = ""
        }
    }
}
#Preview {
    MyWebBrowserView()
}

struct WebViewTextSelectionModifier: ViewModifier {
    let textSelection: Bool
    func body(content: Content) -> some View {
        if textSelection {
            content
                .webViewTextSelection(.enabled)
        } else {
            content
                .webViewTextSelection(.disabled)
        }
    }
}

extension View {
    func webViewTextSelection(_ textSelection: Bool) -> some View {
        modifier(WebViewTextSelectionModifier(textSelection: textSelection))
    }
}
