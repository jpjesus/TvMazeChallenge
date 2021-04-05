//
//  Array+Extensions.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
