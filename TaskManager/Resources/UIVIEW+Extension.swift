//
//  UIVIEW+Extension.swift
//  TaskManager
//
//  Created by Paul Ghibeaux on 14/01/2022.
//

import Foundation
import SwiftUI



// - MARK: UI Design helper functions
extension View {
    func hLeading()->some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()->some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter()->some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}
