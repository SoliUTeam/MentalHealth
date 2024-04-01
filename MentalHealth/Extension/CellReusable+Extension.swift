//
//  CellReusable+Extension.swift
//  MentalHealth
//
//  Created by Yoon on 3/31/24.
//

import Foundation

import UIKit

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension CellReusable {
    static var reuseIdentifier: String {
         String(describing: self)
    }
}

