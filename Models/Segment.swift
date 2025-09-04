import SwiftUI

struct Segment: Identifiable {
    var id = UUID()
    var start: CGPoint
    var end: CGPoint
    var length: Float {
        sqrtf(Float(pow(start.x - end.x, 2.0) + pow(start.y - end.y, 2.0)))
    }
    
    init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
    }
    init(startX: CGFloat, startY: CGFloat, endX: CGFloat, endY: CGFloat) {
        self.start = CGPoint(x: startX, y: startY)
        self.end = CGPoint(x: endX, y: endY)
    }
}
