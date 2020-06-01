//
//  CardViewSample.swift
//  
//
//  Created by Igor Malyarov on 01.06.2020.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct CardViewSample<Content: View>: View {
    public var content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content()
            .padding(10)
    }
}
