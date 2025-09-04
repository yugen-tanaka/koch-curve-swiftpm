import SwiftUI

struct FBSettingView2: View {
   @State private var isDrawing = true
    @State private var segments: [Segment] = []
    
    @GestureState private var location: CGPoint = CGPoint.zero
    @State private var startPoint: CGPoint?
    @State private var currentIndex: Int?
    
    var body: some View {
        VStack {
            Toggle("DrawingMode", isOn: $isDrawing)
                .keyboardShortcut("t")
            
            ZStack {
                if isDrawing {
                    Rectangle()
                        .foregroundStyle(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 30.0, coordinateSpace: .local)
                                .updating($location) { value, state, transaction in
                                    if isExistPoint(value.startLocation) {
                                        
                                    } else {
                                        state = value.location
                                    }
                                }
                                .onChanged { value in
                                    if isExistPoint(value.startLocation) {
                                        let (index, isEnd): (Int?,Bool?) = getNearPointIndex(currenP: value.startLocation)
                                        if let unwrappedIndex = index, let unwrappedIsEnd = isEnd {
                                           if unwrappedIsEnd {
                                               segments[unwrappedIndex].start = value.location
                                           } else {
                                               segments[unwrappedIndex].end = value.location
                                           }
                                        }
                                    } else {
                                        startPoint = value.startLocation
                                    }
                                }
                                .onEnded { value in
                                    if startPoint != nil {
                                        
                                    
                                    segments.append(Segment(start: value.startLocation, end: value.location))
                                }
                                    startPoint = nil
                                }
                            
                        )
                }
                Path { path in
                    if let unwrappedStartPoint = startPoint {
                        path.move(to: unwrappedStartPoint)
                        path.addLine(to: location)
                    }
                }
                .stroke(style: StrokeStyle(lineWidth: 3.0,lineCap: .round))
                .foregroundStyle(.secondary)
                
                
                ForEach(0..<segments.count, id: \.self) { i in 
                    
                    Path { path in
                        path.move(to: segments[i].start)
                        path.addLine(to: segments[i].end)
                    }    
                    .stroke(style: StrokeStyle(lineWidth: 3.0,lineCap: .round))
                    .foregroundStyle(currentIndex == i ? .red : .secondary)
                    .onLongPressGesture {
                        segments.remove(at: i)
                        
                    }
                    
                    Circle()
                        .foregroundStyle(.blue)
                        .frame(width: 15.0, height: 15.0)
                    
                        .padding()
                        .position(segments[i].start)
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    segments[i].start = value.location 
//                                    if let nearPoint = getNearPoint(i: i, currentP: segments[i].start)
//                                    {
//                                        segments[i].start = nearPoint
//                                    }
//                                }
//                        )
                    
                    
                    Circle()
                        .frame(width: 15.0, height: 15.0)
                        .foregroundStyle(.green)
                        .position(segments[i].end)
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    segments[i].end = value.location 
//                                    if let nearPoint = getNearPoint(i: i, currentP: segments[i].end)
//                                    {
//                                        segments[i].end = nearPoint
//                                    }
//                                }
//                        )
                }
                
            }
            
            
        }
    }
}
extension FBSettingView2 {
    func getNearPoint(currentP: CGPoint) -> CGPoint? {
//        
//        let segmentsWithoutMe: [Segment] = segments.filter { 
//            $0.id != segments[i].id 
//        }
//        let points: [CGPoint] = segmentsWithoutMe
//            .map { $0.start }
//            .filter { $0.getDistance(to: currentP) < 15.0} +
//        segmentsWithoutMe
//            .map {$0.end}
//            .filter {$0.getDistance(to: currentP) < 15.0}
//        return points.sorted(by: { $0.getDistance(to: currentP) < $1.getDistance(to: currentP)}).first        
        let points = segments.map { $0.start } + segments.map { $0.end }
        return points.filter { $0.getDistance(to: currentP) < 15.0}
            .sorted(by: { $0.getDistance(to: currentP) < $1.getDistance(to: currentP) })
            .first
       
        
    }
    func getNearPointIndex(currenP: CGPoint) -> (Int?, Bool?) {
        var index: Int?
        var isEnd: Bool?
        for i in 0..<segments.count {
            if segments[i].start.getDistance(to: currenP) < 15 {
                index = i
                isEnd = false
                break
            } else if segments[i].end.getDistance(to: currenP) < 15 {
                index = i
                isEnd = false
                break
            }
        }
        return (index, isEnd)
    }
    
    func isExistPoint(_ currentP: CGPoint) -> Bool {
        let points = segments.map { $0.start } + segments.map { $0.end }
        return !points.filter { $0.getDistance(to: currentP) < 15.0}.isEmpty
    }
}

#Preview {
    FBSettingView2()
    
}
