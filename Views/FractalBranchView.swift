import SwiftUI

struct FractalBranchView: View {
    @State private var isShowSetting = false
    
    @State private var settingSegments: [Segment] = []
    @State private var segments: [(CGPoint, CGPoint)] = [(CGPoint.zero, CGPoint.zero)]
    @State private var generation = 1
    @State private var generationMax = 5
    @State private var branchConfigs: [BranchConfig] = [
        BranchConfig(start: (0.0, 0.0), end: (0.3, 0.1)),
        BranchConfig(start: (0.3, 0.1), end: (0.4, -0.1)),
        BranchConfig(start: (0.4, -0.1), end: (1.0, 0.0)),
        BranchConfig(start: (0.4, -0.1), end: (0.8, -0.4)),
        BranchConfig(start: (0.4, -0.1), end: (0.8, 0.5))
    ]
    @State private var color: Color = .green
    @State private var  currentScale = 1.0
    
    private let scales = [0.25,0.5,0.75,1.0,1.25,1.5,2.0]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    Path { path in
                        for segment in segments {
                            path.move(to: segment.0)
                            path.addLine(to: segment.1)
                        }
                        
                    }
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(color)
//                    ForEach(segments, id: \.0.x) { segment in
//                    Circle()
//                            .frame(width: 10.0, height: 10.0)
//                            .position(segment.0)
//                            .foregroundStyle(Color.pink)
//                    }
                }
              
                VStack {
                    
                    Stepper("generation: \(generation)", value: $generation,in: 1...generationMax, onEditingChanged: { _ in
                        segments = FractalBranch().makeFractalBranch(start: CGPoint(x: geo.size.width * ((1.0-currentScale)/2.0), y: geo.size.height / 2.0), end: CGPoint(x: geo.size.width * (0.5 + currentScale / 2.0), y: geo.size.height / 2.0), branchConfigs: branchConfigs, generation: generation)
                    })
                        
                            
                        }
            }
            .toolbar {
                ToolbarItem {
                    ColorPicker("Color", selection: $color)
                        .labelsHidden()
                }
                ToolbarItem {
                    Button {
                        isShowSetting.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Menu(String(Int(currentScale * 100))+"%") {
                        ForEach(scales, id: \.self) { scale in
                            Button(String(Int(scale * 100))+"%") {
                                currentScale = scale
                            }
                        }
                    }
                }
            }
            .navigationTitle("Fractal Branch")
        }
        .sheet(isPresented: $isShowSetting) {
            generation = 1
            if branchConfigs.count >= 8 {
                generationMax = 5
            } else if branchConfigs.count >= 6 {
                generationMax = 6
            } else if branchConfigs.count >= 4 {
                generationMax = 7
            } else if branchConfigs.count >= 3 {
                generationMax = 8
            } else {
                generationMax = 10
            }
        } content: {
            FBSettingView3(segments: $settingSegments, branchConfigs: $branchConfigs )
        }
    }
}



#Preview {
    FractalBranchView()
}
