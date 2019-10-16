//
//  TabsView.swift
//  Swift-UI
//
//  Created by Patryk Mieszała on 16/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftUI
import Shared

struct TabsView: View {
    init() {
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = Colors.brandColor
        UITabBar.appearance().barStyle = .black
    }
    
    let nf: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "en_EN")
        nf.numberStyle = NumberFormatter.Style.spellOut
        
        return nf
    }()
    
    var body: some View {
        TabView {
            WalletView()
            .tabItem {
                Image(systemName: "1.square.fill")
                Text("Dashboard")
            }
            
            ForEach((2...5), id: \.self) { index in
                NavigationView {
                    List {
                        Text("")
                    }
                }
                .navigationBarTitle(Text("Page \(self.string(from: NSNumber(value: index)))"))
                .tabItem {
                    self.image(forItemAt: index)
                    Text(self.title(forItemAt: index))
                }
            }
        }
        .accentColor(Color(.white))
    }
}

extension TabsView {
    func image(forItemAt index: Int) -> Image? {
        switch index {
        case 3: return nil
        default: return Image(systemName: "\(index).square.fill")
        }
    }
    
    func title(forItemAt index: Int) -> String {
        switch index {
        case 1: return "Dashboard"
        case 2: return "Plan"
        case 4: return "Statystyki"
        case 5: return "Więcej"
        default: return ""
        }
    }
    
    func string(from number: NSNumber) -> String {
        return nf.string(from: number) ?? ""
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
