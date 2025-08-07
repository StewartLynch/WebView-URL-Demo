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


import Foundation

enum Reachability {
    static func checkURL(_ urlString: String) async -> Bool {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            // Get headers only.  No need at this point to get the body
            request.httpMethod = "HEAD"
            do {
                let (_, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse {
                    return (200...399).contains(httpResponse.statusCode)
                }
            } catch {
                print("Request failed with error: \(error)")
            }
            return false
        } else {
            // Invalid URL
            return false
        }
    }
}
