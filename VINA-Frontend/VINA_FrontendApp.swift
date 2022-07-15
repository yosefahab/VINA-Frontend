//
//  VINAApp.swift
//  VINA
//
//  Created by Youssef Ahab on 05/07/2022.
//

import SwiftUI

@main
struct VINAApp: App {
    
    var body: some Scene {
        WindowGroup {
            NewsSheetView(vm: ArticleListViewModel())
                .background(TransparentEffect())
        }
        .windowStyle(.hiddenTitleBar)
        
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif

    }
}
