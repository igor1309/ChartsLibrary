//
//  LineWithAreaChartView.swift
//  TestingAreaCharts
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
            LineChartInsettableShape(series: series,
                                     isZeroBased: isZeroBased,
                                     hasArea: true)
                .fill(fillStyle)
            
            LineChartInsettableShape(series: series,
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

//  MARK: -
@available(iOS 13.0, *)
struct LineWithAreaChartView_Previews: PreviewProvider {
    
    static let gradient = LinearGradient(
        gradient: Gradient(colors: [
            Color.secondary.opacity(0.3),
            Color.secondary.opacity(0.1)]),
        startPoint: .top,
        endPoint: .bottom)
    
    static var lineWithAreaChartView: some View {
        VStack {
            Text("LineWithAreaChartView")
                .font(.subheadline)
            
            HStack {
                LineWithAreaChartView(
                    series: series,
                    isZeroBased: true,
                    areaStyle: Color.secondary,
                    strokeContent: Color.secondary
                )
                    .border(Color.pink.opacity(0.3))
                
                LineWithAreaChartView(
                    series: series,
                    isZeroBased: true,
                    areaStyle: gradient,
                    strokeContent: Color.secondary.opacity(0.75),
                    lineWidth: 4
                )
                    .border(Color.pink.opacity(0.3))
                
                LineWithAreaChartView(
                    series: series,
                    isZeroBased: false,
                    areaStyle: gradient,
                    strokeContent: Color.secondary,
                    lineWidth: 2
                )
                    .border(Color.pink.opacity(0.3))
            }
        }
        .frame(height: 160)
    }
    
    static var previews: some View {
        lineWithAreaChartView
            .padding()
//            .previewColorSchemes()
        //        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        //        .environment(\.colorScheme, .dark)
        //        .previewLayout(.sizeThatFits)
    }
}
