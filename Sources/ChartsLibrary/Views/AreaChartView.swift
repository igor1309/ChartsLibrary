//
//  AreaChartView.swift
//  TestingAreaCharts
//
//  Created by Igor Malyarov on 27.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct AreaChartView<S: ShapeStyle>: View {
    public let series: [CGFloat]
    public let isZeroBased: Bool
    public let fillStyle: S
    
    public var body: some View {
        LineChartInsettableShape(series: series,
                                 isZeroBased: isZeroBased,
                                 hasArea: true)
            .fill(fillStyle)
    }
}

//  MARK: -
@available(iOS 13.0, *)
struct AreaChartView_Previews: PreviewProvider {
    
    static var areaChartView: some View {
        VStack {
            Text("AreaChartView")
                .font(.subheadline)
            
            HStack {
                AreaChartView(series: series,
                              isZeroBased: true,
                              fillStyle: Color.secondary)
                    .border(Color.pink.opacity(0.3))
                
                AreaChartView(series: series,
                              isZeroBased: false,
                              fillStyle: Color.secondary.opacity(0.4))
                    .border(Color.pink.opacity(0.3))
                
                AreaChartView(series: series,
                              isZeroBased: false,
                              fillStyle: LinearGradient(gradient: Gradient(colors: [Color.blue, .blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .border(Color.pink.opacity(0.3))            }
        }
        .frame(height: 160)
    }
    
    static var previews: some View {
        areaChartView
            .padding()
//            .previewColorSchemes()
        //        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        //        .environment(\.colorScheme, .dark)
        //        .previewLayout(.sizeThatFits)
    }
}
