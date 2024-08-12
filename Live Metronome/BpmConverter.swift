//
//  BpmConverter.swift
//  Live Metronome
//
//  Created by Fernando del Pino on 12/08/24.
//

import Foundation

class BpmConverter {
    
    static func getBpm(from interval:Double) -> Int {
        Int(60/interval)
    }
    
    static func getInterval(from bpm:Int) -> Double {
        Double(60)/Double(bpm)
    }
}
