import SwiftUI
import Foundation

class Model: ObservableObject {
    @Published var points: [CGPoint] = []
    @Published var generation = 3
    @Published var settingPoints: [CGPoint] = []
    
    
    @Published var r1:Float
    @Published var r2: Float
    @Published var r3: Float
    @Published var angle1: Float
    @Published var angle2: Float
    @Published var angle3: Float
    
    
    init(r1: Float = 0.333, r2: Float = 0.577, r3: Float = 0.666, angle1: Float = 0.0, angle2: Float = Float.pi/6.0, angle3: Float = 0.0) {
        self.r1 = r1
        self.r2 = r2
        self.r3 = r3
        self.angle1 = angle1
        self.angle2 = angle2
        self.angle3 = angle3
    }
    
    func generateKochCurve(startPoint: CGPoint, endPoint: CGPoint) {
        let koch = Koch()
        
        self.points = koch.makeKochCurve(startPoint: startPoint, endPoint: endPoint, r1: CGFloat(r1), r2: CGFloat(r2), r3: CGFloat(r3), angle1: -CGFloat(angle1), angle2: -CGFloat(angle2), angle3: -CGFloat(angle3), generation: generation)
        
    }
    
    func generateSettingPoints(startPoint: CGPoint, endPoint: CGPoint) {
        
        let koch = Koch()
        self.settingPoints = koch.makeKochCurve(startPoint: startPoint, endPoint: endPoint, r1: 0.333, r2: 0.577, r3: 0.666, angle1: 0.0, angle2: -CGFloat.pi / 6.0, angle3: 0.0, generation: 1)
    }
    func savePattern() {
        if settingPoints.isEmpty || settingPoints.count < 5 {
            return
        }
        print("save pattern")
        
        let startPoint = settingPoints.first!
        let endPoint = settingPoints.last!
        print(startPoint, endPoint)
        let distanceStartEnd = getDistance(from: endPoint, to: startPoint)
        print(distanceStartEnd)
        var angles: [Float] = []
        
        r1 = getDistance(from: settingPoints[1], to: startPoint) / distanceStartEnd
        r2 = getDistance(from: settingPoints[2], to: startPoint) / distanceStartEnd
        r3 = getDistance(from: settingPoints[3], to: startPoint) / distanceStartEnd
        
        let a3 = getDistance(from: settingPoints[3], to: startPoint)
        let b3 = getDistance(from: endPoint, to: settingPoints[3])
        angle3 = acosf((pow(a3, 2.0)  + pow(distanceStartEnd, 2.0) - pow(b3, 2.0)) / 2.0 / a3 / distanceStartEnd)
        if settingPoints[3].y > startPoint.y {
            angle3 *= -1.0
        }
        
        let a2 = getDistance(from: settingPoints[2], to: startPoint)
        let b2 = getDistance(from: endPoint, to: settingPoints[2])
        angle2 = acosf((pow(a2, 2.0)  + pow(distanceStartEnd, 2.0) - pow(b2, 2.0)) / 2.0 / a2 / distanceStartEnd)
        if settingPoints[2].y > startPoint.y {
            angle2 *= -1.0
        }
        
        let a1 = getDistance(from: settingPoints[1], to: startPoint)
        let b1 = getDistance(from: endPoint, to: settingPoints[1])
        angle1 = acosf((pow(a1, 2.0)  + pow(distanceStartEnd, 2.0) - pow(b1, 2.0)) / 2.0 / a1 / distanceStartEnd)
        if settingPoints[1].y > startPoint.y {
            angle1 *= -1.0
        }
    }
    func savePattern2() {
        print("Run savePattern()")
        if settingPoints.isEmpty || settingPoints.count < 5 {
            print("error")
            return
        }
        let startPoint = settingPoints.first!
        let endPoint = settingPoints.last!
        let distanceStartEnd = getDistance(from: endPoint, to: startPoint)
        print("distanceStartEnd: ", distanceStartEnd)
        var angles: [Float] = []
        
        //        //ratioを計算して代入
        //        r1 = getDistance(from: settingPoints[1], to: startPoint) / distanceStartEnd
        //        r2 = getDistance(from: settingPoints[2], to: startPoint) / distanceStartEnd
        //        r3 = getDistance(from: settingPoints[3], to: startPoint) / distanceStartEnd
        //ここにangleの計算を追加↓
        for point in settingPoints.dropFirst().dropLast() {
            let a = getDistance(from: point, to: startPoint)
            let b = getDistance(from: endPoint, to: point)
            print((pow(a, 2.0) + pow(b, 2.0) - pow(distanceStartEnd, 2.0)) / 2.0 * a * b)
            
            //            
            //            let angle = acos((pow(a, 2.0) + pow(b, 2.0)) / 2.0 * a * b)
            //            angles.append(angle)
        }
        for i in 1...angles.count {
            switch i {
            case 1: angle1 = angles[i]
            case 2: angle2 = angles[i]
            case 3: angle3 = angles[i]
            default: break
            }
        }
    }
    
    private func getDistance(from p1: CGPoint, to p2: CGPoint) -> Float {
        //2点間の距離を求める。
        let dx = Double(p1.x - p2.x)
        let dy = Double(p1.y - p2.y)
        return Float(sqrt(dx * dx + dy * dy)) 
    }
}


