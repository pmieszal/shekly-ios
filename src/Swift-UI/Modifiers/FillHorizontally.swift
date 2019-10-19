//
//  FillHorizontally.swift
//  Swift-UI
//
//  Created by Patryk Mieszała on 19/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftUI

struct FillHorizontally: ViewModifier {
  func body(content: Content) -> some View {
    content.frame(minWidth: 0, maxWidth: .infinity)
  }
}

extension View {
  func fillHorizontally() -> some View {
    self.modifier(FillHorizontally())
  }
}
