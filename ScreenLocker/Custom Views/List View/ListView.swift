//
//  ListView.swift
//  ScreenLocker
//
//  Created by Alex on 22.11.2024.
//

import SwiftUI

struct ListView: View {
    
    let items: [ListItem.Config]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<items.count, id: \.self) { index in
                VStack(spacing: 0) {
                    ListItem(config: items[index])
                    
                    if index < items.count - 1 {
                        Divider()
                    }
                }
            }
        }
    }
}
