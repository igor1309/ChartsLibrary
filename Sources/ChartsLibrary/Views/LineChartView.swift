//
//  LineChartView.swift
//  TestingAreaCharts
//
//  Created by Igor Malyarov on 27.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct LineChartView<S: ShapeStyle>: View {
    public let series: [CGFloat]
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

//  MARK: -
@available(iOS 13.0, *)
struct LineChartView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        var line1: some View {
            HStack {
                LineChartView(series: series,
                              isZeroBased: true,
                              strokeContent: Color.secondary)
                    .background(Color.secondary.opacity(0.2))
                
                ZStack {
                    LineChartView(series: series,
                                  isZeroBased: true,
                                  strokeContent: Color.secondary)
                    
                    MovingAverageLineChartView(series: series,
                                               averagingPeriod: 7,
                                               isZeroBased: true,
                                               strokeContent: Color.orange,
                                               lineWidth: 2)
                }
                .background(Color.secondary.opacity(0.2))
            }
        }
        
        var line2: some View {
            HStack {
                LineChartView(series: series,
                              isZeroBased: false,
                              strokeContent: Color.secondary)
                    .background(Color.secondary.opacity(0.2))
                
                ZStack {
                    LineChartView(series: series,
                                  isZeroBased: false,
                                  strokeContent: Color.secondary)
                        .background(Color.secondary.opacity(0.2))
                    
                    MovingAverageLineChartView(series: series,
                                               averagingPeriod: 7,
                                               isZeroBased: false,
                                               strokeContent: Color.orange,
                                               lineWidth: 2)
                        .background(Color.secondary.opacity(0.2))
                }
            }
        }
        
        return VStack(spacing: 16) {
            Text("LineChartView & MovingAveragesLineChart")
                .font(.subheadline)
            Divider()
            
            VStack {
                Text("isZeroBased: true")
                    .font(.footnote)
                line1
                
                Text("isZeroBased: false")
                    .font(.footnote)
                    .padding(.top)
                line2
            }
        }
        .frame(width: 300, height: 450)
        .padding()
//        .previewColorSchemes()
        //        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        //        .environment(\.colorScheme, .dark)
        //        .previewLayout(.sizeThatFits)
    }
}

