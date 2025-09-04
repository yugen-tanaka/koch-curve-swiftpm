import SwiftUI

struct ContentView: View {
    @StateObject var model = Model()
    @State private var points: [CGPoint] = []
    @State private var isShowingSetting = false
    @State private var yPosition: Float = 0.5
    @State private var color: Color = .accentColor
    @State private var isFullScreen = false
    @State private var isShowingFBSetting2 = false
    
    @GestureState private var magnifyBy = 1.0
    
    var magnification: some Gesture {
        MagnifyGesture()
            .updating($magnifyBy) { value, gestureState, transaction in
                gestureState = value.magnification
            }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    if !model.points.isEmpty {
                        Path { path in
                            path.move(to: model.points.first!)
                            for i in 1..<model.points.count {
                                path.addLine(to: model.points[i])
                            }
                        }
                        .stroke(lineWidth: 0.9)
                        .foregroundStyle(color)
                        .position(CGPoint(x: geo.size.width / 2.0, y: (geo.size.height - 20.0) * CGFloat(yPosition)))
                        .scaleEffect(magnifyBy)
                        .gesture(magnification)                        
                    } else {
                        VStack {
                            Spacer()
                             Text("Push Generate")
                                .foregroundStyle(Color.secondary)
                            Spacer()
                        }
                    }
                    if !isFullScreen {
                    Stepper("Generation: \(model.generation)", value: $model.generation, in: 1...7, step: 1, onEditingChanged: { _ in
                        model.generateKochCurve(startPoint: CGPoint(x: 20.0, y: geo.size.height * 0.66), endPoint: CGPoint(x: geo.size.width - 20.0, y: geo.size.height * 0.66))
                    })
                }
                    HStack {
                        if !isFullScreen {
                            Button {
                                model.generateKochCurve(startPoint: CGPoint(x: 20.0, y: geo.size.height * 0.66), endPoint: CGPoint(x: geo.size.width - 20.0, y: geo.size.height * 0.66))
                            } label: {
                                Label("Generate", systemImage: "arrow.clockwise")
                            }
                            .buttonStyle(BorderedProminentButtonStyle())
                        } 
                        Spacer()
                        Button {
                            withAnimation {
                                isFullScreen.toggle()
                            }
                        } label: {
                            Image(systemName: isFullScreen ? "arrow.up.right.and.arrow.down.left":"arrow.down.left.and.arrow.up.right")
                        }                        
                    }
                    .padding()
                }
            }
            .navigationTitle(isFullScreen ? "":"Koch Curve")
            .toolbar {
                if !isFullScreen {
                ToolbarItem {
                    ColorPicker("Color", selection: $color)
                        .labelsHidden()
                }
                    
                ToolbarItem {
                    Button {
                        isShowingSetting.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                    ToolbarItem(placement: .bottomBar) {
                        Slider(value: $yPosition, in: 0.0...1.0)
                    }
            }
            }
            
        } 
        .fullScreenCover(isPresented: $isShowingSetting, onDismiss: {}, content: {
            SettingView()
                .environmentObject(model)
        })
        
    }
}
