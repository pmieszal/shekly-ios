//
//  MainView.swift
//  Swift-UI
//
//  Created by Patryk Mieszała on 16/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftUI
import Shared

struct MainView: View {
    var body: some View {
        ZStack(alignment: .bottom, content: {
            TabsView()
            NewEntryButton {
                log.debug("New entry button tapped")
            }
            .padding()
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
