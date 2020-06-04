//
//  LineWithAreaChartView.swift
//  ChartsLibrary
//
//  Created by Igor Malyarov on 27.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct LineWithAreaChartView<S1: ShapeStyle, S2: ShapeStyle>: View {
    public let series: [CGFloat]
    public let isZeroBased: Bool
    public let fillStyle: S1
    public let strokeContent: S2
    public var lineWidth: CGFloat
    public let lineCap: CGLineCap
    public let lineJoin: CGLineJoin
    public let miterLimit: CGFloat
    public let dash: [CGFloat]
    public let dashPhase: CGFloat
    
    public init(
        series: [CGFloat],
        isZeroBased: Bool = true,
        areaStyle: S1,
        strokeContent: S2,
        lineWidth: CGFloat = 1,
        lineCap: CGLineCap = .round,
        lineJoin: CGLineJoin = .round,
        miterLimit: CGFloat = 10,
        dash: [CGFloat] = [CGFloat](),
        dashPhase: CGFloat = 0
    ) {
        self.series = series
        self.isZeroBased = isZeroBased
        self.fillStyle = areaStyle
        self.strokeContent = strokeContent
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.lineJoin = lineJoin
        self.miterLimit = miterLimit
        self.dash = dash
        self.dashPhase = dashPhase
    }
    
    public var body: some View {
        ZStack {
            LineChart(series: series,
                      isZeroBased: isZeroBased,
                      hasArea: true)
                .fill(fillStyle)
            
            LineChart(series: series,
                      isZeroBased: isZeroBased,
                      hasArea: false)
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
}
