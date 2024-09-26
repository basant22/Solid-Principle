//
//  MyRegion.swift
//  Solid Principle
//
//  Created by Kumar Basant on 18/07/24.
//

import Foundation
import MapKit
extension MKCoordinateRegion{
    static var myRegion:MKCoordinateRegion{
        self.init(center: .mylocation, latitudinalMeters: 50000, longitudinalMeters: 50000)
    }
}
