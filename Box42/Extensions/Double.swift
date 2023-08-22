//
//  Double.swift
//  Box42
//
//  Created by Chanhee Kim on 8/16/23.
//

extension Double {
    var roundedToTwoDecimalPlaces: Double {
        return (self * 100).rounded() / 100
    }
}
