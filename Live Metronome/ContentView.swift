//
//  ContentView.swift
//  Live Metronome
//
//  Created by Fernando del Pino on 09/08/24.
//

import SwiftUI

struct ContentView: View {
    private let BUTTON_COLOR: Color = .green
    private let BACKGROUND_COLOR: Color = .black
    @State private var backgroundColor: Color = .black
    @State private var time = ProcessInfo.processInfo.systemUptime
    @State private var bpm = 120
    @State private var flag: Bool = false
    @State private var optionalTimer: Timer?
    @FocusState private var textFieldFocused: Bool
    
    var body: some View {
        
        VStack {
            
            VStack{
                Text("BPM")
                TextField("", value: $bpm, format: .number)
                    .keyboardType(.numberPad)
                    .focused($textFieldFocused)
            }
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .foregroundColor(BUTTON_COLOR)
            
            Button("Tap") {
                let tmp = ProcessInfo.processInfo.systemUptime
                bpm = BpmConverter.getBpm(from: tmp-time)
                time = tmp
                textFieldFocused = false
            }
            .buttonStyle(.borderedProminent)
            .tint(BUTTON_COLOR)
            
            Button("Start") {
                let interval = BpmConverter.getInterval(from: bpm)
                if let timer = optionalTimer {
                    timer.invalidate()
                }
                optionalTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
                    timerJob()
                }
                textFieldFocused = false
            }
            .buttonStyle(.borderedProminent)
            .tint(BUTTON_COLOR)
            
            Button("Stop") {
                if let timer = optionalTimer {
                    timer.invalidate()
                }
                backgroundColor = BACKGROUND_COLOR
                textFieldFocused = false
            }
            .buttonStyle(.borderedProminent)
            .tint(BUTTON_COLOR)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            backgroundColor.ignoresSafeArea()
        }
        
    }// end body
    
    func timerJob() {
        if (flag) {
            backgroundColor = BACKGROUND_COLOR
            flag = false
        } else{
            backgroundColor = BUTTON_COLOR
            flag = true
        }
    }
    
} // end ContentView

#Preview {
    ContentView()
}
