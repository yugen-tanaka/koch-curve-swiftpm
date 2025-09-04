import Foundation

class FractalBranch {
     func makeFractalBranch(start: CGPoint, end: CGPoint, branchConfigs: [BranchConfig], generation: Int) -> [(CGPoint, CGPoint)] {
        var segments: [(CGPoint, CGPoint)] = [(start, end)]
        
        Array(0..<generation).forEach { i in
            var segments2: [(CGPoint, CGPoint)] = []
            for segment in segments {
                segments2.append(contentsOf: makePattern(initialSegment: segment,branchConfigs:branchConfigs ))
            }
            segments = segments2
        }
        return segments
    }
    
    private func makePattern(initialSegment: (start: CGPoint, end: CGPoint), branchConfigs:[BranchConfig])-> [(CGPoint, CGPoint)] {

        branchConfigs.map { 
            (
                initialSegment.end.scaleRotated(ratio: $0.start.ratio, angle: $0.start.angle, centerPoint: initialSegment.start),
                initialSegment.end.scaleRotated(ratio: $0.end.ratio, angle: $0.end.angle, centerPoint: initialSegment.start)
            )
            }
        
        
    }
    func setPointsConfig(_ segments: [Segment]) -> (ratio: CGFloat, angle: CGFloat) {
        return (0.0,0.0)
    }
    func setConnection(_ segments: [Segment]) -> (startIndex: Int, endIndex: Int) {
        return (0,1)
    }
}
