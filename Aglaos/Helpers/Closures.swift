//
//  Closures.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation

typealias Completion = () -> Void
typealias Closure<T> = (T) -> Void

func onMain(_ work: @escaping Completion) {
    DispatchQueue.main.async(execute: work)
}

func onBG(_ work: @escaping Completion) {
    DispatchQueue.global().async(execute: work)
}
