import SwiftUI

struct FractalBranchView: View {
    @State private var isShowSetting = false
    
    @State private var segments2: [(CGPoint, CGPoint)] = [(CGPoint.zero, CGPoint.zero)]
    @State private var segments: [(CGPoint, CGPoint)] = [(CGPoint.zero, CGPoint.zero)]
    @State private var generation = 1
    @State private var branchConfigs: [BranchConfig] = [
        BranchConfig(start: (0.0, 0.0), end: (0.3, 0.1)),
        BranchConfig(start: (0.3, 0.1), end: (0.4, -0.1)),
        BranchConfig(start: (0.4, -0.1), end: (1.0, 0.0)),
        BranchConfig(start: (0.4, -0.1), end: (0.8, -0.4)),
        BranchConfig(start: (0.4, -0.1), end: (0.8, 0.5))
    ]
    
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
                    .foregroundStyle(Color.green)
//                    ForEach(segments, id: \.0.x) { segment in
//                    Circle()
//                            .frame(width: 10.0, height: 10.0)
//                            .position(segment.0)
//                            .foregroundStyle(Color.pink)
//                    }
                }
              
                VStack {
                    Button("make fractal branch") {
                        segments = FractalBranch().makeFractalBranch(start: CGPoint(x: 0.0, y: geo.size.height / 2.0), end: CGPoint(x: geo.size.width, y: geo.size.height / 2.0), branchConfigs: branchConfigs, generation: generation)
                    }
                    .padding(10.0)
                    Stepper("generation: \(generation)", value: $generation,in: 1...7, onEditingChanged: { _ in
                        segments = FractalBranch().makeFractalBranch(start: CGPoint(x: 0.0, y: geo.size.height / 2.0), end: CGPoint(x: geo.size.width, y: geo.size.height / 2.0), branchConfigs: branchConfigs, generation: generation)
                    })
                        
                            
                        }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isShowSetting.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowSetting) {
            print("dismiss")
            print(branchConfigs)
        } content: {
            FBSettingView3( branchConfigs: $branchConfigs)
        }
    }
}



#Preview {
    FractalBranchView()
}
