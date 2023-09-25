//import AudioKit
//import AudioKitEX
//import AudioKitUI
//import AudioToolbox
//import Keyboard
//import SoundpipeAudioKit
//import SwiftUI
//
//struct OscillatorView: View {
//    @State var ampValue: AUValue = 1.0
//    @State var freqValue: AUValue = 1000
//    @StateObject var conductor = OscillatorConductor()
//    
//    @State private var laserPosition: CGPoint = CGPoint(x: 50, y: 50)
//    @State private var isDragging: Bool = false
//
//    var body: some View {
//        VStack {
//            Spacer()
//            GeometryReader { geometry in
//                ZStack {
//                    RoundedRectangle(cornerRadius: 5.0)
//                        .padding()
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    let location = value.location
//                                    laserPosition = location
//                                    isDragging = true
//                                    freqValue = AUValue(location.x)
//                                    ampValue = AUValue(location.y * 0.1)
//                                    conductor.updateValues(amp: ampValue, freq: freqValue)
//                                }
//                                .onEnded { _ in
//                                    isDragging = false
//                                }
//                        )
//                    //if isDragging {
//                                        Circle()
//                                            .fill(Color.red)
//                                            .frame(width: 15)
//                                            .position(laserPosition)
//                                            .shadow(color: .red, radius: 25, x: 0, y: 0)
//                                   // }
//                                }
//                                
//                            }
//                        
//                }
//            Text(conductor.isPlaying ? "STOP" : "START")
//                .foregroundColor(.blue)
//                .onTapGesture {
//                    conductor.isPlaying.toggle()
//                }
//            Spacer()
//        }
//}
//
//
//class OscillatorConductor: ObservableObject, HasAudioEngine {
//    let engine = AudioEngine()
//    
//    var ampValue: AUValue = 1.0 {
//        didSet {
//            osc.amplitude = ampValue
//        }
//    }
//    var freqValue: AUValue = 1000 {
//        didSet {
//            osc.frequency = freqValue
//        }
//    }
//
//    @Published var isPlaying: Bool = false {
//        didSet { isPlaying ? osc.start() : osc.stop() }
//    }
//
//    var osc = Oscillator()
//
//    init() {
//        osc.amplitude = ampValue
//        osc.frequency = freqValue
//        engine.output = osc
//        do {
//            try engine.start()
//        } catch {
//            print("Failed to start AudioEngine:", error)
//        }
//    }
//    
//    func updateValues(amp: AUValue, freq: AUValue) {
//        self.ampValue = amp
//        self.freqValue = freq
//    }
//}
//
//
//


// 2

//
//import AudioKit
//import AudioKitEX
//import AudioKitUI
//import AudioToolbox
//import Keyboard
//import SoundpipeAudioKit
//import SwiftUI
//
//struct OscillatorView: View {
//    @State var ampValue: AUValue = 1.0
//    @State var freqValue: AUValue = 1000
//    @StateObject var conductor = OscillatorConductor()
//    
//    @State private var laserPosition: CGPoint = CGPoint(x: 50, y: 50)
//    @State private var isDragging: Bool = false
//    @State private var curvePoints: [CGPoint] = []
//
//    var body: some View {
//        VStack {
//            Spacer()
//            GeometryReader { geometry in
//                ZStack {
//                    RoundedRectangle(cornerRadius: 5.0)
//                        .padding()
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    let location = value.location
//                                    laserPosition = location
//                                    curvePoints.append(location)
//                                    isDragging = true
//                                    freqValue = AUValue(location.x)
//                                    ampValue = AUValue(location.y * 0.1)
//                                    conductor.updateValues(amp: ampValue, freq: freqValue)
//                                }
//                                .onEnded { _ in
//                                    isDragging = false
//                                }
//                        )
//                    
//                    Path { path in
//                        if let firstPoint = curvePoints.first {
//                            path.move(to: firstPoint)
//                            for point in curvePoints {
//                                path.addLine(to: point)
//                            }
//                        }
//                    }
//                    .stroke(Color.blue, lineWidth: 2)
//                    
//                    Circle()
//                        .fill(Color.red)
//                        .frame(width: 15)
//                        .position(laserPosition)
//                        .shadow(color: .red, radius: 25, x: 0, y: 0)
//                }
//            }
//            Text(conductor.isPlaying ? "STOP" : "START")
//                .foregroundColor(.blue)
//                .onTapGesture {
//                    conductor.isPlaying.toggle()
//                }
//            Spacer()
//        }
//    }
//}
//
//class OscillatorConductor: ObservableObject, HasAudioEngine {
//    let engine = AudioEngine()
//    
//    var ampValue: AUValue = 1.0 {
//        didSet {
//            osc.amplitude = ampValue
//        }
//    }
//    var freqValue: AUValue = 1000 {
//        didSet {
//            osc.frequency = freqValue
//        }
//    }
//
//    @Published var isPlaying: Bool = false {
//        didSet { isPlaying ? osc.start() : osc.stop() }
//    }
//
//    var osc = Oscillator()
//
//    init() {
//        osc.amplitude = ampValue
//        osc.frequency = freqValue
//        engine.output = osc
//        do {
//            try engine.start()
//        } catch {
//            print("Failed to start AudioEngine:", error)
//        }
//    }
//    
//    func updateValues(amp: AUValue, freq: AUValue) {
//        self.ampValue = amp
//        self.freqValue = freq
//    }
//}

// 3
import AudioKit
import AudioKitEX
import AudioKitUI
import AudioToolbox
import Keyboard
import SoundpipeAudioKit
import SwiftUI

struct OscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    @State private var laserPosition: CGPoint = CGPoint(x: 50, y: 50)
    @State private var curvePoints: [CGPoint] = []
    @State private var MAX_OSCILLATORS: Int = 100
    @State private var timer: Timer? = nil

    var body: some View {
        VStack {
            
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let location = value.location
                                    laserPosition = location
                                    curvePoints.append(location)
                                    conductor.updateValues(points: curvePoints)
                                    if curvePoints.count >= MAX_OSCILLATORS {
                                        curvePoints.removeFirst()
                                        conductor.updateValues(points: curvePoints)
                                    }

                                }
                        )
                    
                    Path { path in
                        if let firstPoint = curvePoints.first {
                            path.move(to: firstPoint)
                            for point in curvePoints {
                                path.addLine(to: point)
                            }
                        }
                    }
                    .stroke(Color.red, lineWidth: 2)
                    .shadow(color: .red, radius: 10, x:0, y:0)
                    
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 15)
                        .position(laserPosition)
                        .shadow(color: .red, radius: 10, x: 0, y: 0)
                }
            }
            .onAppear {
                // Start the timer when the view appears
                    self.timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
                        if curvePoints.count > 0 {
                            self.curvePoints.removeFirst()
                            conductor.updateValues(points: curvePoints)
                        }
                    }
            }
            .onDisappear {
                // Invalidate the timer when the view disappears
                self.timer?.invalidate()
            }
            Text("Reset")
                .foregroundColor(.red)
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
                .onTapGesture {
                    if conductor.areAnyPlaying == true {
                        curvePoints = []
                        conductor.updateValues(points: curvePoints)
                        conductor.toggleAll()
                    } else {
                        curvePoints = []
                        conductor.updateValues(points: curvePoints)
                        conductor.toggleAll()
                        conductor.toggleAll()
                    }
                    
                }

            
        }.background(Color.black)
    }
        
        
}

class OscillatorConductor: ObservableObject {
    let engine = AudioEngine()
    var oscs: [Oscillator] = []
    let mixer = Mixer()
    let maxOscillators = 100

    @Published var areAnyPlaying: Bool = true {
        didSet {
            if areAnyPlaying {
                    for osc in oscs {
                        osc.start()
                    }
                
            } else {
                for osc in oscs {
                    osc.stop()
                }
            }
        }
    }

    init() {
        for _ in 0..<maxOscillators {
            let osc = Oscillator()
            oscs.append(osc)
            mixer.addInput(osc)
        }
        engine.output = mixer
        do {
            try engine.start()
        } catch {
            print("Failed to start AudioEngine:", error)
        }
    }
        
    
    func updateValues(points: [CGPoint]) {
        for (index, point) in points.suffix(maxOscillators).enumerated() {
            let osc = oscs[index]
            osc.frequency = AUValue(max(min(point.x * 10, 2000), 20)) // Ensuring frequency is within 20Hz to 2000Hz
            osc.amplitude = AUValue(max(min(1.0 - (point.y / UIScreen.main.bounds.height), 1.0), 0.1)) // Ensuring amplitude is between 0.1 and 1.0
            osc.start()
        }
    }
    
        func toggleAll() {
            areAnyPlaying.toggle()
    }
   
}



