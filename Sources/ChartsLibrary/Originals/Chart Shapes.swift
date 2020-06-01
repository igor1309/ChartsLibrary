//
//  Chart Shapes.swift
//  TestingAreaCharts
//
//  Created by Igor Malyarov on 24.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
fileprivate struct LineChartShape: Shape {
    let series: [CGFloat]
    var min: CGFloat?
    var max: CGFloat?
    var isZeroBased = true
    var hasArea = false
    
    func path(in rect: CGRect) -> Path {
        guard !series.isEmpty else { return Path() }
        
        let min = self.min ?? series.min()!
        let max = self.max ?? series.max()!
        
        let xStep = rect.width / CGFloat(series.count - 1)
        
        func point(index: Int) -> CGPoint {
            CGPoint(
                x: xStep * CGFloat(index),
                y: rect.height * (1 - (series[index] - (isZeroBased ? 0 : min)) / (isZeroBased ? max : (max - min)))
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

@available(iOS 13.0, *)
fileprivate struct MovingAveragesLineChartShape: Shape {
    let series: [CGFloat]
    var min: CGFloat?
    var max: CGFloat?
    var averagingPeriod: Int = 7
    var isZeroBased = true
    var hasArea = false
    
    func path(in rect: CGRect) -> Path {
        guard !series.isEmpty else { return Path() }
        
        let min = self.min ?? series.min()!
        let max = self.max ?? series.max()!
        
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

//  MARK: -
@available(iOS 13.0, *)
struct LineChartShapeTesting: View {
    let series = [CGFloat(10), 20, 50, 10]
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.tertiarySystemBackground))
            
            Rectangle()
                .stroke(Color(UIColor.systemTeal), style: StrokeStyle(lineWidth: 0.5, dash: [10]))
            
            LineChartShape(series: series, isZeroBased: true)
                .stroke(Color.pink, lineWidth: 1)
            
            LineChartShape(series: series, isZeroBased: false)
                .stroke(Color.yellow, lineWidth: 1)
            
            MovingAveragesLineChartShape(series: series)
                .stroke(Color.purple, lineWidth: 4)
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(Color(UIColor.tertiarySystemFill))
    }
}

@available(iOS 13.0, *)
struct LineChartShape_Previews: PreviewProvider {
    static var previews: some View {
        LineChartShapeTesting()
            
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .environment(\.colorScheme, .dark)
            .previewLayout(.sizeThatFits)
    }
}
