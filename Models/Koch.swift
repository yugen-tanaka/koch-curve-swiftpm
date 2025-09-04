import SwiftUI

class Koch: ObservableObject {
    
    func makeKochCurve(startPoint: CGPoint, endPoint: CGPoint, ratio: [Float], angle: Float) -> [CGPoint] {
        return []
    }
    func makeKochCurve(startPoint: CGPoint, endPoint:CGPoint, r1: CGFloat, r2: CGFloat, r3: CGFloat, angle1: CGFloat, angle2: CGFloat, angle3: CGFloat, generation: Int) -> [CGPoint] {
        var points: [CGPoint] = [startPoint, endPoint]
        for _ in 0..<generation {
            for j in 0..<points.count-1 {
                points[4*j...4*j] = makePattern(startPoint: points[4*j], endPoint: points[4*j+1], r1: r1, r2: r2, r3: r3, angle1: angle1, angle2: angle2, angle3: angle3)
            }
        }
        return points
    }
    
    
    private func makePattern(startPoint: CGPoint, endPoint:CGPoint, r1: CGFloat, r2: CGFloat, r3: CGFloat, angle1: CGFloat, angle2: CGFloat, angle3: CGFloat) -> ArraySlice<CGPoint> {
        var points: ArraySlice<CGPoint>
        let point1 = endPoint.scaleRotated(ratio: r1, angle: angle1, centerPoint: startPoint)
        let point2 = endPoint.scaleRotated(ratio: r2, angle: angle2, centerPoint: startPoint)
        let point3 = endPoint.scaleRotated(ratio: r3, angle: angle3, centerPoint: startPoint)
    
        points = [startPoint, point1, point2, point3]
        return points
    }
}



