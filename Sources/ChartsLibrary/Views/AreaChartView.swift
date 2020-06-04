//
//  AreaChartView.swift
//  ChartsLibrary
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
    
    public init(series: [CGFloat], isZeroBased: Bool, fillStyle: S) {
        self.series = series
        self.isZeroBased = isZeroBased
        self.fillStyle = fillStyle
    }
    
    public var body: some View {
        LineChart(series: series,
                  isZeroBased: isZeroBased,
                  hasArea: true)
            .fill(fillStyle)
    }
}
