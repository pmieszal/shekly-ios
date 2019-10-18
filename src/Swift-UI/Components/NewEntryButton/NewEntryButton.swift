//
//  NewEntryButton.swift
//  Swift-UI
//
//  Created by Patryk Mieszała on 16/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftUI
import Shared

struct NewEntryButton: View {
    let action: () -> ()
    
    var body: some View {
        Button(action: action,
               label: {
                Image(systemName: "plus")
                    .accentColor(Color(Colors.brandColor))
                    .imageScale(Image.Scale.large)
                    .padding(EdgeInsets(top: 25, leading: 30, bottom: 25, trailing: 30))
        })
            .background(
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(.white))
        )
    }
}

struct NewEntryButton_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryButton(action: {})
    }
}
