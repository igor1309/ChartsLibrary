//
//  CardsWithChartsSample.swift
//  TestingAreaCharts
//
//  Created by Igor Malyarov on 27.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct CardsWithChartsSample: View {
    public var body: some View {
        VStack {
            HStack {
                CardViewSample {
                    ZStack(alignment: .topTrailing) {
                        LineChartView(series: series.map { CGFloat($0) },
                                      isZeroBased: false,
                                      strokeContent: Color(UIColor.lightGray), lineWidth: 0.5)
                        
                        Text("Line Chart")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                CardViewSample {
                    LineChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: true,
                                  strokeContent: Color.secondary, lineWidth: 0.5)
                }
            }
            
            HStack {
                CardViewSample {
                    ZStack(alignment: .topTrailing) {
                        LineChartView(series: series.map { CGFloat($0) },
                                      isZeroBased: false,
                                      strokeContent: Color(UIColor.lightGray))
                        
                        Text("Line Chart")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                CardViewSample {
                    ZStack(alignment: .bottomLeading) {
                        LineChartView(series: series.map { CGFloat($0) },
                                      isZeroBased: true,
                                      strokeContent: Color.secondary)
                        Text("driving")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
            }
            
            HStack {
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: false,
                                  fillStyle: Color.yellow)
                }
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: true,
                                  fillStyle: Color.secondary)
                }
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: true,
                                  fillStyle: Color(UIColor.tertiaryLabel))
                }
            }
            
            HStack {
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: true,
                                  fillStyle: Color(UIColor.secondarySystemFill))
                }
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: true,
                                  fillStyle: Color(UIColor.tertiarySystemFill))
                }
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: true,
                                  fillStyle: Color(UIColor.quaternarySystemFill))
                }
            }
            
            HStack {
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: false,
                                  fillStyle: Color(UIColor.secondarySystemFill))
                }
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: false,
                                  fillStyle: Color(UIColor.tertiarySystemFill))
                }
                CardViewSample {
                    AreaChartView(series: series.map { CGFloat($0) },
                                  isZeroBased: false,
                                  fillStyle: Color(UIColor.quaternarySystemFill))
                }
            }
        }
        .padding()
    }
}

//  MARK: -
@available(iOS 13.0, *)
struct CardsWithChartsSample_Previews: PreviewProvider {
    static var previews: some View {
        CardsWithChartsSample()
//            .previewColorSchemes()
    }
}
