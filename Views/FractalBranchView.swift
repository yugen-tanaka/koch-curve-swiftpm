import SwiftUI

struct FractalBranchView: View {
    @State private var isShowSetting = false
    let pointsConfig: [(ratio: CGFloat, angle: CGFloat)] = [
        (0.0, 0.0),
        (0.3, 0.1),
        (0.4, -0.1),
        (1.0, 0.0),
        (0.8, 0.5),
        (0.8, -0.4)
    ]
    let connection: [(startIndex: Int, endIndex: Int)] = [
    (0,1),
    (2,3),
    (2,4),
    (2,5)
    ]
    @State private var segments2: [(CGPoint, CGPoint)] = [(CGPoint.zero, CGPoint.zero)]
    @State private var segments: [Segment] = .init()
    @State private var generation = 1
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    Path { path in
                        for segment in segments2 {
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
                        segments2 = FractalBranch().makeFractalBranch(start: CGPoint(x: 0.0, y: geo.size.height / 2.0), end: CGPoint(x: geo.size.width, y: geo.size.height / 2.0), pointsConfig: pointsConfig, connection: connection, generation: generation)
                    }
                    .padding(10.0)
                    Stepper("generation: \(generation)", value: $generation,in: 1...8, onEditingChanged: { _ in
                        segments2 = FractalBranch().makeFractalBranch(start: CGPoint(x: 0.0, y: geo.size.height / 2.0), end: CGPoint(x: geo.size.width, y: geo.size.height / 2.0), pointsConfig: pointsConfig,connection: connection, generation: generation)
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
        } content: {
            FBSettingView3(resultSegments: $segments)
        }
    }
}

extension FractalBranchView {
    func setConfig(_ segments: [Segment]) {
        
    }
}

#Preview {
    FractalBranchView()
}
