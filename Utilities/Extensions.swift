import SwiftUI

extension CGPoint {
    func scaleRotated(ratio: CGFloat,angle: CGFloat,centerPoint: CGPoint) -> CGPoint {
       return self
            .applying(CGAffineTransform(translationX: -centerPoint.x, y: -centerPoint.y))
            .applying(CGAffineTransform(rotationAngle: angle))
            .applying(CGAffineTransform(scaleX: ratio, y: ratio))
            .applying(CGAffineTransform(translationX: centerPoint.x, y: centerPoint.y))
    }
    func getDistance(to: CGPoint) -> Float {
        return sqrtf(Float(pow(to.x - self.x, 2.0) + pow(to.y - self.y, 2.0)))
    }
}
