//
//  TipKit.swift
//  Solid Principle
//
//  Created by Kumar Basant on 18/07/24.
//

import Foundation
import TipKit

struct AddColorTip:Tip{
    var title: Text{
        Text("Add New Color")
            .foregroundStyle(.teal)
    }
    var message: Text?{
        Text("Tap here to add a new color to the list")
    }
    
    var image: Image?{
        Image(systemName: "paintpalette")
            
    }
}
struct SetFavoriteTip:Tip{
    static let setFavoriteEvent = Event(id:"setFavorite")
    static let colorViewVisitedEvent = Event(id:"colorViewVisited")
    var title: Text{
        Text("Set Favorites")
    }
    var message: Text?{
        Text("Tap and hold a color to add it to your favorites")
    }
    
    var image: Image?{
        Image(systemName: "paintpalette")
    }
    var rules: [Rule]{
        #Rule(Self.setFavoriteEvent) { event in
            event.donations.count == 0
        }
        #Rule(Self.colorViewVisitedEvent){event in
            event.donations.count > 2
        }
    }
}
