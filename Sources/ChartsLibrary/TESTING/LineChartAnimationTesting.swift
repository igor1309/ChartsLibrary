//
//  LineChartAnimationTesting.swift
//  TestingAreaCharts
//
//  Created by Igor Malyarov on 26.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension LineChartInsettableShape {
    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(minY, maxY)
        }
        set {
            minY = newValue.first
            maxY = newValue.second
        }
    }
}

@available(iOS 13.0, *)
struct LineChartAnimationTesting: View {
    @State private var on = false
    
    var body: some View {
        VStack {
            if on {
                LineChartInsettableShape(series: series,
                                         averagingPeriod: 7,
                                         isZeroBased: false,
                                         hasArea: false)
                    .strokeBorder(Color.orange, lineWidth: 2)
                    .transition(.scaleAndFade)
            } else {
                Rectangle()
                    .fill(Color.clear)
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                self.on = true
            }
        }
        .padding()
    }
}

@available(iOS 13.0, *)
struct LineChartAnimationTesting_Previews: PreviewProvider {
    static var previews: some View {
        LineChartAnimationTesting()
            .padding()
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .environment(\.colorScheme, .dark)
    }
}

//  MARK: - From Apple's Building Custom Views in SwiftUI

/// The custom view modifier defining the transition applied to each
/// wedge view as it's inserted and removed from the display.
@available(iOS 13.0, *)
struct ScaleAndFade: ViewModifier {
    /// True when the transition is active.
    var isEnabled: Bool
    
    // Scale and fade the content view while transitioning in and
    // out of the container.
    
    func body(content: Content) -> some View {
        return content
            .scaleEffect(isEnabled ? 0.1 : 1)
            .opacity(isEnabled ? 0 : 1)
    }
}

@available(iOS 13.0, *)
extension AnyTransition {
    static let scaleAndFade = AnyTransition.modifier(
        active: ScaleAndFade(isEnabled: true),
        identity: ScaleAndFade(isEnabled: false))
}
