import SwiftUI

struct Segment: Identifiable {
    var id = UUID()
    var start: CGPoint
    var end: CGPoint
    var length: Float {
        sqrtf(Float(pow(start.x - end.x, 2.0) + pow(start.y - end.y, 2.0)))
    }
    var direction: Float {
        atan2f(Float(end.x-start.x),Float(end.y-start.y))
    }
    
    init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
    }
    init(startX: CGFloat, startY: CGFloat, endX: CGFloat, endY: CGFloat) {
        self.start = CGPoint(x: startX, y: startY)
        self.end = CGPoint(x: endX, y: endY)
    }
    
    func getBranchConfig(parent:Segment) -> BranchConfig {
        let startRatio = self.start.getDistance(to:parent.start) / parent.length
        let startAngle = parent.direction - atan2f(Float(self.start.x - parent.start.x),Float(self.start.y - parent.start.y))
        let endRatio = self.end.getDistance(to:parent.start) / parent.length
        let endAngle = parent.direction - atan2f(Float(self.end.x-parent.start.x),Float(self.end.y-parent.start.y))

        return BranchConfig(start: (CGFloat(startRatio),CGFloat(startAngle)),
        end: (CGFloat(endRatio),CGFloat(endAngle)))

    }
}
