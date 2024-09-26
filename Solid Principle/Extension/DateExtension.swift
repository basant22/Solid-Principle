//
//  DateExtension.swift
//  Solid Principle
//
//  Created by Kumar Basant on 30/07/24.
//

import Foundation

extension Date{
    func toString()-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        
       return formatter.string(from: self)
    }
}
