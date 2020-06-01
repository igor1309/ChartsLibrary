//
//  Ext+Array.swift
//  ChartsLibrary
//
//  Created by Igor Malyarov on 25.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

extension Array where Element: BinaryInteger {
    public func movingAverages(period: Int = 7) -> [Double] {
        guard !self.isEmpty else { return [] }
        guard period > 1 else { return self.map { Double($0) } }
        
        var movingAverages = [Double]()
        for i in 1...self.count {
            let prefix = self.prefix(i)
            let suffix = prefix.suffix(period)
            let movingAverage = suffix.map { Double($0) }.reduce(0, +) / Double(suffix.count)
            movingAverages.append(movingAverage)
        }
        return movingAverages
    }
}

extension Array where Element: BinaryFloatingPoint {
    public func movingAverages(period: Int = 7) -> [Double] {
        guard !self.isEmpty else { return [] }
        guard period > 1 else { return self.map { Double($0) } }
        
        var movingAverages = [Double]()
        for i in 1...self.count {
            let prefix = self.prefix(i)
            let suffix = prefix.suffix(period)
            let movingAverage = suffix.map { Double($0) }.reduce(0, +) / Double(suffix.count)
            movingAverages.append(movingAverage)
        }
        return movingAverages
    }
}
