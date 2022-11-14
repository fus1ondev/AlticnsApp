//
//  ContentView.swift
//  AlticnsApp
//
//  Created by Fus1onDev on 2022/11/14.
//

import SwiftUI

struct ContentView: View {
    @State private var applications: [Application] = []
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 100, maximum: 150))]
    
    let defaultAppIcon = NSWorkspace.shared.icon(for: .application)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(applications.sorted(by: { $0.name < $1.name }), id: \.url) { app in
                    VStack {
                        Image(nsImage: app.icon ?? defaultAppIcon)
                        Text(app.name)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            getAppUrls()
        }
    }
    
    private func getAppUrls() {
        do {
            let appDir = try FileManager.default.url(for: .applicationDirectory,
                                                     in: .localDomainMask,
                                                     appropriateFor: nil,
                                                     create: true)
            if let enumerator = FileManager.default.enumerator(at: appDir, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
                for case let fileURL as URL in enumerator {
                    let isApp: Bool = (try? fileURL.resourceValues(forKeys: [.isApplicationKey]))?.isApplication ?? false
                    if isApp {
                        print(fileURL)
                        applications.append(Application(url: fileURL))
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
