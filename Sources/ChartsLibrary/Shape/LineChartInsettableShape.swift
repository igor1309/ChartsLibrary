//
//  LineChartInsettableShape.swift
//  TestingAreaCharts
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

//  MARK: -
@available(iOS 13.0, *)
struct LineChartInsettableShape_Previews: PreviewProvider {
    static var shortSeries: [CGFloat] = [300, 70, 500, 520, 475, 520, 510, 500]
    static var lineWidth: CGFloat = 15
    
    static var previews: some View {
        Group {
            VStack(spacing: 16) {
                
                VStack {
                    Text("strokeBorder")
                    LineChartInsettableShape(series: series, hasArea: true)
                        .strokeBorder(Color(UIColor.systemTeal), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        .border(Color.secondary, width: 0.5)
                        .frame(width: 400, height: 260)
                }
                
                //  MARK: - strokeBorder, inset + stroke, no inset + stroke
                
                HStack(spacing: 16) {
                    
                    //  strokeBorder
                    VStack {
                        Text("strokeBorder")
                        LineChartInsettableShape(series: shortSeries, hasArea: true)
                            .strokeBorder(Color(UIColor.systemTeal), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                            .border(Color.secondary, width: 0.5)
                    }
                    
                    //  inset + stroke
                    VStack {
                        Text("inset + stroke")
                        LineChartInsettableShape(series: shortSeries, hasArea: true)
                            .inset(by: lineWidth / 2)
                            .stroke(Color(UIColor.systemTeal), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                            .border(Color.secondary, width: 0.5)
                    }
                    
                    VStack {
                        Text("no inset + stroke")
                        LineChartInsettableShape(series: shortSeries, hasArea: true)
                            .stroke(Color(UIColor.systemTeal), lineWidth: lineWidth)
                            .border(Color.secondary)
                    }
                }
                .frame(width: 400, height: 260)
                
                Divider()
                
                //  MARK: - fill
                
                HStack(spacing: 16) {
                    
                    //  strokeBorder
                    VStack {
                        Text("fill: no inset")
                        LineChartInsettableShape(series: shortSeries, hasArea: true)
                            .fill(Color(UIColor.systemTeal))
                            .border(Color.secondary, width: 0.5)
                    }
                    
                    //  inset + stroke
                    VStack {
                        Text("fill: inset")
                        LineChartInsettableShape(series: shortSeries, hasArea: true)
                            .inset(by: lineWidth / 2)
                            .fill(Color(UIColor.systemTeal))
                            .border(Color.secondary, width: 0.5)
                    }
                    
                    VStack {
                        Text("–")
                        Rectangle()
                            .fill(Color.clear)
                            .border(Color.secondary)
                    }
                }
                .frame(width: 400, height: 260)
                
                Divider()
                
                HStack {
                    
                    //  MARK: - Zero Based
                    VStack {
                        Text("series original & moving everage")
                        ZStack {
                            LineChartInsettableShape(series: shortSeries,
                                                     hasArea: false)
                                .strokeBorder(Color.blue, lineWidth: 1)
                            
                            LineChartInsettableShape(series: shortSeries,
                                                     averagingPeriod: 7,
                                                     hasArea: false)
                                .strokeBorder(Color.orange, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        }
                        .border(Color.secondary, width: 0.5)
                        .frame(width: 180, height: 220)
                    }
                    .padding()
                    .background(Color(UIColor.quaternarySystemFill))
                    
                    Divider()
                    
                    //  MARK: - Min Based
                    
                    VStack {
                        Text("series original & moving everage | isZeroBased = false")
                        ZStack {
                            LineChartInsettableShape(series: shortSeries,
                                                     isZeroBased: false,
                                                     hasArea: false)
                                .strokeBorder(Color.blue, lineWidth: 1)
                            
                            LineChartInsettableShape(series: shortSeries,
                                                     averagingPeriod: 7,
                                                     isZeroBased: false,
                                                     hasArea: false)
                                .strokeBorder(Color.orange, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                            
                        }
                        .border(Color.secondary, width: 0.5)
                        .frame(width: 180, height: 220)
                    }
                    .padding()
                    .background(Color(UIColor.quaternarySystemFill))
                }
            }
        }
        .font(.caption)
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .environment(\.colorScheme, .dark)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("LineChartInsettableShape")
    }
}
