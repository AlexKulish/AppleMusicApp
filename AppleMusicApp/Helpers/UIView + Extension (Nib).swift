//
//  UIView + Extension (Nib).swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 19.09.2022.
//

import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
    }
    
}
