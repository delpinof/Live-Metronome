//
//  BPMConverterTest.swift
//  LiveMetronomeTest
//
//  Created by Fernando del Pino on 12/08/24.
//

import XCTest
@testable import Live_Metronome

final class BPMConverterTest: XCTestCase {
    
    func testGetBpmFromDouble() {
        // given
        let interval = 0.5
        // when
        let bpm = BpmConverter.getBpm(from: interval)
        // then
        XCTAssertEqual(bpm, 120)
    }
    
    func testGetIntervalFromBpm() {
        // given
        let bpm = 120
        // when
        let interval = BpmConverter.getInterval(from: bpm)
        // then
        XCTAssertEqual(interval, 0.5)
    }
    
    func testGetIntervalFromBpm180() {
        // given
        let bpm = 180
        // when
        let interval = BpmConverter.getInterval(from: bpm)
        // then
        XCTAssertEqual(interval, 60/3)
    }

}
