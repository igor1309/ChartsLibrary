//
//  LineChart.swift
//  ChartsLibrary
//
//  Created by Igor Malyarov on 26.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

/// Insettable shape for line or area chart. See init documentation for details.
@available(iOS 13.0, *)
public struct LineChart: InsettableShape {
    public let series: [CGFloat]
    public var count: Int
    public let minY: CGFloat
    public let maxY: CGFloat
    public var averagingPeriod: Int
    public var isZeroBased: Bool
    public var hasArea: Bool
    
    /// Insettable shape for line (default) or area chart (hasArea = true).
    /// Plot `original` series (period = 0 or 1) or `moving average` (if period > 1).
    /// Provide `min` and/or `max` to set Y Axis, otherwise use series min and max.
    /// Use `zero` (default) or `min` to set Y Axis (isZeroBased).
    /// For `line` chart use with strokeBorder() to inset, for `area` use fill().
    /// Use `count` to animate chart drawing - ex: from 0 to count.
    /// - Parameters:
    ///   - series: original series used to plot it or moving average
    ///   - minY: min value of Y Axix, if not provided derived from series
    ///   - maxY: max value of Y Axix, if not provided derived from series
    ///   - averagingPeriod: use value below or equal to 1 to plot original series, other value to plot moving average with this averaging period
    ///   - isZeroBased: use sero (default, true) or min (false) to set min Y Axis value
    ///   - hasArea: plot line (default, false) or area chart (true)
    ///   - count: used for animation
    public init(
        series: [CGFloat],
        count: Int? = nil,
        minY: CGFloat? = nil,
        maxY: CGFloat? = nil,
        averagingPeriod: Int = 0,
        isZeroBased: Bool = true,
        hasArea: Bool = false
    ) {
        self.series = series
        self.count = count == nil ? series.count : Swift.min(count!, series.count)
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
    
    public var animatableData: Double {
        get { Double(count) }
        set { count = Int(newValue) }
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            guard !series.isEmpty && count > 0 else { return }
            
            let xStep: CGFloat = (rect.width - insetAmount * 2) / CGFloat(series.count - 1)
            
            let yZero: CGFloat = isZeroBased ? 0 : minY
            let yStep: CGFloat = (rect.height - insetAmount * 2) / (maxY - yZero)
            
            func point(_ i: Int) -> CGPoint {
                let x = CGFloat(i) * xStep + insetAmount
                let yValue: CGFloat = CGFloat(series.movingAverages(period: averagingPeriod)[i])
                let y = rect.height - ((yValue - yZero) * yStep + insetAmount)
                return CGPoint(x: x, y: y)
            }
            
            path.move(to: point(0))
            
            for i in 1..<count {
                path.addLine(to: point(i))
            }
            
            if hasArea {
                path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.maxY - insetAmount))
                path.addLine(to: CGPoint(x: rect.minX + insetAmount, y: rect.maxY - insetAmount))
                path.closeSubpath()//addLine(to: point(index: 0))
            }
        }
    }
}
