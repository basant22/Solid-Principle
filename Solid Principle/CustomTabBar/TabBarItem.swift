//
//  TabBarItem.swift
//  Solid Principle
//
//  Created by Kumar Basant on 25/10/24.
//

import Foundation
import SwiftUI
enum TabBarItem:Hashable{
    case home,favirite,profile
    var tabIcon:String{
        switch self {
        case .home:
            "house"
        case .favirite:
            "heart"
        case .profile:
            "person"
        }
    }
    var title:String{
        switch self {
        case .home:
            "Home"
        case .favirite:
            "Favorites"
        case .profile:
            "Person"
        }
    }
    var color:Color{
        switch self {
        case .home:
            Color.red
        case .favirite:
            Color.blue
        case .profile:
            Color.green
        }
    }
}

