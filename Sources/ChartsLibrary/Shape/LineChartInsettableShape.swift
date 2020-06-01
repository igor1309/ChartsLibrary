//
//  LineChartInsettableShape.swift
//  ChartsLibrary
//
//  Created by Igor Malyarov on 26.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

/// Insettable shape for line or area chart. See init documentation for details.
@available(iOS 13.0, *)
public struct LineChartInsettableShape: InsettableShape {
    public let series: [CGFloat]
    public var minY: CGFloat
    public var maxY: CGFloat
    public var averagingPeriod: Int
    public var isZeroBased: Bool
    public var hasArea: Bool
    
    /// Insettable shape for line (default) or area chart (hasArea = true).
    /// Plot original series (period = 0 or 1) or moving average (if period > 1).
    /// Provide min and/or max to set Y Axis, otherwise use series min and max.
    /// Use zero (default) or min to set Y Axis (isZeroBased).
    /// For line chart use with strokeBorder() to inset, for area use fill().
    /// - Parameters:
    ///   - series: original series used to plot it or moving average
    ///   - minY: min value of Y Axix, if not provided derived from series
    ///   - maxY: max value of Y Axix, if not provided derived from series
    ///   - averagingPeriod: use value below or equal to 1 to plot original series, other value to plot moving average with this averaging period
    ///   - isZeroBased: use sero (default, true) or min (false) to set min Y Axis value
    ///   - hasArea: plot line (default, false) or area chart (true)
    public init(
        series: [CGFloat],
        minY: CGFloat? = nil,
        maxY: CGFloat? = nil,
        averagingPeriod: Int = 0,
        isZeroBased: Bool = true,
        hasArea: Bool = false
    ) {
        self.series = series
        self.minY = minY ?? series.min() ?? 0
        self.maxY = maxY ?? series.max() ?? 1
        self.averagingPeriod = averagingPeriod
        self.isZeroBased = isZeroBased
        self.hasArea = hasArea
    }
    
    public var insetAmount: CGFloat = 0
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var chart = self
        chart.insetAmount += amount
        return chart
    }
    
    public func path(in rect: CGRect) -> Path {
        guard !series.isEmpty else { return Path() }
        
        let xStep = (rect.width - insetAmount * 2) / CGFloat(series.count - 1)
        
        func point(index: Int) -> CGPoint {
            let yValue: CGFloat = CGFloat(series.movingAverages(period: averagingPeriod)[index])
            let yZero: CGFloat = isZeroBased ? 0 : minY
            let yHeight: CGFloat = (isZeroBased ? maxY : (maxY - minY))
            
            return CGPoint(
                x: xStep * CGFloat(index) + insetAmount,
                y: (rect.height - insetAmount * 2) * (1 - (yValue - yZero) / yHeight) + insetAmount
            )
        }
        
        return Path { path in
            path.move(to: point(index: 0))
            
            for index in 1..<series.count {
                path.addLine(to: point(index: index))
            }
            
            if hasArea {
                path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.maxY - insetAmount))
                path.addLine(to: CGPoint(x: rect.minX + insetAmount, y: rect.maxY - insetAmount))
                path.closeSubpath()//addLine(to: point(index: 0))
            }
        }
    }
}
