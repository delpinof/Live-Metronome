//
//  ContentView.swift
//  Live Metronome
//
//  Created by Fernando del Pino on 09/08/24.
//

import SwiftUI

struct ContentView: View {
    private let buttonColor: Color = .blue
    @State private var backgroundColor: Color = .white
    @State private var time = ProcessInfo.processInfo.systemUptime
    @State private var bpm = 120
    @State private var flag: Bool = false
    @State private var optionalTimer: Timer?
    @FocusState private var textFieldFocused: Bool
    
    var body: some View {
        
        VStack {
            
            HStack{
                Text("BPM")
                TextField("", value: $bpm, format: .number)
                    .keyboardType(.numberPad)
                    .focused($textFieldFocused)
            }
            .font(.largeTitle)
            
            Button("Tap") {
                let tmp = ProcessInfo.processInfo.systemUptime
                bpm = BpmConverter.getBpm(from: tmp-time)
                time = tmp
                textFieldFocused = false
            }
            .buttonStyle(.borderedProminent)
            .tint(buttonColor)
            
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
            .tint(buttonColor)
            
            Button("Stop") {
                if let timer = optionalTimer {
                    timer.invalidate()
                }
                backgroundColor = .white
                textFieldFocused = false
            }
            .buttonStyle(.borderedProminent)
            .tint(buttonColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            backgroundColor.ignoresSafeArea()
        }
        
    }// end body
    
    func timerJob() {
        if (flag) {
            backgroundColor = .white
            flag = false
        } else{
            backgroundColor = .red
            flag = true
        }
    }
    
} // end ContentView

#Preview {
    ContentView()
}
