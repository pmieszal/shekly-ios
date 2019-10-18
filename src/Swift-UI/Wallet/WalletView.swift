//
//  WalletView.swift
//  Swift-UI
//
//  Created by Patryk Mieszała on 16/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftUI
import Shared

struct WalletView: View {
    var body: some View {
        NavigationView {
            List {
                WalletEntryListItem()
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
