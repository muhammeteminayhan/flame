//
//  ContentView.swift
//  flame
//
//  Created by Muhammet Emin Ayhan on 6.11.2024.
//

import SwiftUI

struct MatchFlameView: View {
    let animationInterval = 1.0 / 60.0
    var body: some View {
        TimelineView(.periodic(from: Date(), by: animationInterval)) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            ZStack(alignment: .bottom) {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                FlameLayer(
                    color: Color.red.opacity(0.8),
                    width: 60,
                    height: 120,
                    rotationAmplitude: 5.0,
                    rotationFrequency: 1.0,
                    scaleAmplitude: 0.1,
                    scaleFrequency: 0.5,
                    time: now + 0.15
                )
                
                FlameLayer(
                    color: Color.orange.opacity(0.8),
                    width: 50,
                    height: 100,
                    rotationAmplitude: 5,
                    rotationFrequency: 1,
                    scaleAmplitude: 0.1,
                    scaleFrequency: 0.5,
                    time: now + 0.1
                )
                
                FlameLayer(
                    color: Color.yellow.opacity(0.8),
                    width: 40,
                    height: 80,
                    rotationAmplitude: 5,
                    rotationFrequency: 1.0,
                    scaleAmplitude: 0.1,
                    scaleFrequency: 0.5,
                    time: now + 0.15
                )
            }
            
        }
    }
    struct FlameLayer: View {
        var color: Color
        var width: CGFloat
        var height: CGFloat
        var rotationAmplitude: Double
        var rotationFrequency: Double
        var scaleAmplitude: Double
        var scaleFrequency: Double
        var time: TimeInterval
        var body: some View {
            let rotationAngle = rotationAmplitude * sin(2 * .pi * rotationFrequency * time)
            let scaleFactor = 1.0 + scaleAmplitude * sin(2 * .pi * scaleFrequency * time)
            FlameShape()
                .fill(color)
                .frame(width: width, height: height)
                .rotationEffect(.degrees(rotationAngle), anchor: .bottom)
                .scaleEffect(CGSize(width: scaleFactor, height: scaleFactor), anchor: .bottom)
        }
    }
    struct FlameShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.width
            let height = rect.height
            
            path.move(to: CGPoint(x: width / 2, y: 0))
            path.addCurve(to: CGPoint(x: 0, y: height * 2/3),
                          control1: CGPoint(x: width / 2, y: height * 0.25),
                          control2: CGPoint(x: 0, y: height * 0.4))
            path.addCurve(to: CGPoint(x: width / 2, y: height),
                          control1: CGPoint(x: 0, y: height * 0.6),
                          control2: CGPoint(x: width / 4, y: height))
            path.addCurve(to: CGPoint(x: width, y: height * 2/3),
                          control1: CGPoint(x: width * 0.75, y: height),
                          control2: CGPoint(x: width, y: height * 0.6))
            path.addCurve(to: CGPoint(x: width / 2, y: 0),
                          control1: CGPoint(x: width, y: height * 0.4),
                          control2: CGPoint(x: width / 2, y: height * 0.25))
            path.closeSubpath()
            return path
            
        }
    }
}

struct ContentView: View {
    var body: some View {
        MatchFlameView()
    }
}

