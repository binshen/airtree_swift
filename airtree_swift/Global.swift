//
// Created by Bin Shen on 9/23/16.
// Copyright (c) 2016 Bin Shen. All rights reserved.
//

import Foundation

let MORAL_API_BASE_PATH: String = "http://api.7drlb.com"

var _loginUser: [String:Any]!
var _selectedDevice: AnyObject!

struct Global {

    static func is_ipad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }

    static func is_iphone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }

    static func is_retina() -> Bool {
        return UIScreen.main.scale >= 2.0
    }

    static func screen_width() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }

    static func screen_height() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    static func screen_max_length() -> CGFloat {
        return max(screen_width(), screen_height())
    }

    static func screen_min_length() -> CGFloat {
        return min(screen_width(), screen_height())
    }

    static func is_iphone_4_or_less() -> Bool {
        return is_iphone() && screen_max_length() < 568.0
    }

    static func is_iphone5() -> Bool {
        return is_iphone() && screen_max_length() == 568.0
    }

    static func is_iphone6() -> Bool {
        return is_iphone() && screen_max_length() == 667.0
    }

    static func is_iphone6p() -> Bool {
        return is_iphone() && screen_max_length() == 736.0
    }
}
