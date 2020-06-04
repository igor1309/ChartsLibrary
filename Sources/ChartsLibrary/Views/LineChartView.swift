//
//  LineChartView.swift
//  ChartsLibrary
//
//  Created by Igor Malyarov on 27.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct LineChartView<S: ShapeStyle>: View {
    let series: [CGFloat]
    let minY: CGFloat?
    let maxY: CGFloat?
    let averagingPeriod: Int
    let isZeroBased: Bool
    let animation: Animation
    let strokeContent: S
    var lineWidth: CGFloat
    let lineCap: CGLineCap
    let lineJoin: CGLineJoin
    let miterLimit: CGFloat
    let dash: [CGFloat]
    let dashPhase: CGFloat
    
    @State private var show = false
    
    public init(
        series: [CGFloat],
        isZeroBased: Bool,
        minY: CGFloat? = nil,
        maxY: CGFloat? = nil,
        averagingPeriod: Int = 0,
        animation: Animation? = Animation.easeInOut(duration: 1),
        strokeContent: S,
        lineWidth: CGFloat = 1,
        lineCap: CGLineCap = .round,
        lineJoin: CGLineJoin = .round,
        miterLimit: CGFloat = 10,
        dash: [CGFloat] = [CGFloat](),
        dashPhase: CGFloat = 0
    ) {
        self.series = series
        self.minY = minY
        self.maxY = maxY
        self.averagingPeriod = averagingPeriod
        self.isZeroBased = isZeroBased
        self.animation = animation ?? .default
        self.strokeContent = strokeContent
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.lineJoin = lineJoin
        self.miterLimit = miterLimit
        self.dash = dash
        self.dashPhase = dashPhase
    }
    
    public var body: some View {
        LineChart(series: series,
                  count: show ? series.count : 0,
                  minY: minY,
                  maxY: maxY,
                  averagingPeriod: averagingPeriod,
                  isZeroBased: isZeroBased,
                  hasArea: false)
            .strokeBorder(strokeContent,
                          style: StrokeStyle(lineWidth: show ? lineWidth : 0,
                                             lineCap: lineCap,
                                             lineJoin: lineJoin,
                                             miterLimit: miterLimit,
                                             dash: dash,
                                             dashPhase: dashPhase
                )
        )
            .onAppear {
                withAnimation(self.animation) {
                    self.show = true
                }
        }
    }
}
