//
//  MovingAverageLineChartView.swift
//  ChartsLibrary
//
//  Created by Igor Malyarov on 27.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct MovingAverageLineChartView<S: ShapeStyle>: View {
    public let series: [CGFloat]
    public var averagingPeriod: Int
    public let isZeroBased: Bool
    public let strokeContent: S
    public var lineWidth: CGFloat
    public let lineCap: CGLineCap
    public let lineJoin: CGLineJoin
    public let miterLimit: CGFloat
    public let dash: [CGFloat]
    public let dashPhase: CGFloat
    
    public init(
        series: [CGFloat],
        averagingPeriod: Int = 7,
        isZeroBased: Bool,
        strokeContent: S,
        lineWidth: CGFloat = 1,
        lineCap: CGLineCap = .round,
        lineJoin: CGLineJoin = .round,
        miterLimit: CGFloat = 10,
        dash: [CGFloat] = [CGFloat](),
        dashPhase: CGFloat = 0
    ) {
        self.series = series
        self.isZeroBased = isZeroBased
        self.averagingPeriod = averagingPeriod
        self.strokeContent = strokeContent
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.lineJoin = lineJoin
        self.miterLimit = miterLimit
        self.dash = dash
        self.dashPhase = dashPhase
    }
    
    public var body: some View {
        LineChartInsettableShape(series: series,
                                 averagingPeriod: averagingPeriod,
                                 isZeroBased: isZeroBased)
            .strokeBorder(strokeContent,
                          style: StrokeStyle(lineWidth: lineWidth,
                                             lineCap: lineCap,
                                             lineJoin: lineJoin,
                                             miterLimit: miterLimit,
                                             dash: dash,
                                             dashPhase: dashPhase
                )
        )
    }
}
