//
//  MovingAveragesLineChartShape.swift
//  ChartsAndCollectionLibrariesDevelopment
//
//  Created by Igor Malyarov on 01.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct MovingAveragesLineChartShape: Shape {
    public let series: [CGFloat]
    public var min: CGFloat
    public var max: CGFloat
    public var averagingPeriod: Int
    public var isZeroBased: Bool
    public var hasArea: Bool
    
    public init(
        series: [CGFloat],
        min: CGFloat? = nil,
        max: CGFloat? = nil,
        averagingPeriod: Int = 7,
        isZeroBased: Bool = true,
        hasArea: Bool = false
    ) {
        self.series = series
        self.min = min ?? series.min()!
        self.max = max ?? series.max()!
        self.averagingPeriod = averagingPeriod
        self.isZeroBased = isZeroBased
        self.hasArea = hasArea
    }
    
    public func path(in rect: CGRect) -> Path {
        guard !series.isEmpty else { return Path() }
        
        let xStep = rect.width / CGFloat(series.count - 1)
        
        func point(index: Int) -> CGPoint {
            CGPoint(
                x: xStep * CGFloat(index),
                y: rect.height * (1 - (CGFloat(series.movingAverages(period: averagingPeriod)[index]) - (isZeroBased ? 0 : min)) / (isZeroBased ? max : (max - min)))
            )
        }
        
        return Path { path in
            path.move(to: point(index: 0))
            
            for index in 1..<series.count {
                path.addLine(to: point(index: index))
            }
            
            if hasArea {
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: point(index: 0))
            }
        }
    }
    
}
