//
//  Optional+Extensions.swift
//  MentalHealth
//
//  Created by JungpyoHong on 5/20/24.
//

import Foundation
import UIKit

extension Optional where Wrapped == Bool {
    var orFalse: Bool {
        guard let self else { return false }
        return self
    }
    
    var orTrue: Bool {
        guard let self else { return true }
        return self
    }
}

extension Optional where Wrapped == String {
    var orBlankString: String {
        guard let self else { return "" }
        return self
    }
}

extension Optional where Wrapped == Int {
    var orZeroValue: Int {
        guard let self else { return 0 }
        return self
    }
}

extension Optional where Wrapped == UIImage {
    var orEmptyImage: UIImage {
        guard let self else { return UIImage() }
        return self
    }
}
