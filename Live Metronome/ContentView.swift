//
//  ContentView.swift
//  Live Metronome
//
//  Created by Fernando del Pino on 09/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor: Color = .white
    @State private var time = ProcessInfo.processInfo.systemUptime
    @State private var bpm = 0
    @State private var diff = 0.0
    @State private var flag: Bool = false
    @State private var scale: CGFloat = 1.0
    @State private var optionalTimer: Timer?
    
    
    var body: some View {
        
        VStack {
            Text("BPM \(bpm)")
            .font(.largeTitle)
            /*Circle()
            .fill(Color.red)
            .frame(width: 100, height: 100)
            .scaleEffect(scale)
            .animation(Animation.easeInOut(duration: diff).repeatForever(autoreverses: true))
            .onAppear {
                startPulsating()
            }*/
            
            Button("Tap") {
                let tmp = ProcessInfo.processInfo.systemUptime
                diff = tmp-time
                bpm = Int(60/diff)
                time = tmp
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Button("Start") {
                if let timer = optionalTimer {
                    timer.invalidate()
                }
                optionalTimer = Timer.scheduledTimer(withTimeInterval: diff, repeats: true) { _ in
                    timerJob()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Button("Stop") {
                if let timer = optionalTimer {
                    timer.invalidate()
                }
                backgroundColor = .white
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
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
    
    func startPulsating() {
        withAnimation {
            scale = 1.5
        }
    }
}

#Preview {
    ContentView()
}
