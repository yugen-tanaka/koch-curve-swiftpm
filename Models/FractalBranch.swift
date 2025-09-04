import Foundation

class FractalBranch {
     func makeFractalBranch(start: CGPoint, end: CGPoint, pointsConfig: [(ratio: CGFloat, angle: CGFloat)], connection: [(startIndex: Int, endIndex: Int)], generation: Int) -> [(CGPoint, CGPoint)] {
        var segments: [(CGPoint, CGPoint)] = [(start, end)]
        
        Array(0..<generation).forEach { i in
            var segments2: [(CGPoint, CGPoint)] = []
            for segment in segments {
                segments2.append(contentsOf: makePattern(initialSegment: segment, pointsConfig: pointsConfig, connection: connection))
            }
            segments = segments2
        }
        return segments
    }
    
    private func makePattern(initialSegment: (start: CGPoint, end: CGPoint), pointsConfig: [(ratio: CGFloat, angle: CGFloat)], connection: [(startIndex: Int, endIndex: Int)])-> [(CGPoint, CGPoint)] {
        let patternPoints: [CGPoint] = pointsConfig.map { initialSegment.end.scaleRotated(ratio: $0.ratio, angle: $0.angle, centerPoint: initialSegment.start)}
        
        return connection.map {
            return (patternPoints[$0.startIndex],patternPoints[$0.endIndex])
        }
    }
    func setPointsConfig(_ segments: [Segment]) -> (ratio: CGFloat, angle: CGFloat) {
        return (0.0,0.0)
    }
    func setConnection(_ segments: [Segment]) -> (startIndex: Int, endIndex: Int) {
        return (0,1)
    }
}
