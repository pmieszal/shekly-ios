//
//  Colors.swift
//  Shared
//
//  Created by Patryk Mieszała on 04/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import DynamicColor

public enum Colors {
    public static let brandColor = UIColor(hex: 0x1D1D53)
    public static let brand2Color = UIColor(hex: 0x292969)
    
    public static var categoryColor: UIColor {
        return brandColor
    }
    
    public static let subcategoryColor = UIColor(hex: 0x1495ce)
    public static let commentColor = UIColor(hex: 0xf9b42d)
    public static let numberColor = UIColor(hex: 0x1e824c)
    
    public static let text1Color = UIColor(hex: 0x8080A7)
    public static let text2Color = UIColor(hex: 0xB4B4D5)
    
    public static let numberGreen = UIColor(hex: 0x23BF00)
    public static let numberRed = UIColor(hex: 0xF42352)
    
    public static let walletEntryBackground = UIColor(hex: 0x2F2F63)
}
