//
//  Solid_PrincipleApp.swift
//  Solid Principle
//
//  Created by Kumar Basant on 10/07/24.
//

import SwiftUI
import TipKit
@main
struct Solid_PrincipleApp: App {
    init() {
    }
   
    @StateObject var router = Router()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(router)
                .environment(RouterNew())
                .task {
                   // try? Tips.resetDatastore()
                    try? Tips.configure(
                        [.displayFrequency(.immediate),
                         .datastoreLocation(.applicationDefault)])
                }
        }
    }
}
