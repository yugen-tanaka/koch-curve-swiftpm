import SwiftUI
import Foundation

struct FBSettingView3: View {
    @Environment(\.dismiss) var dismiss
    @State private var segments: [Segment] = []
    @Binding var resultSegments: [Segment]
    
    @GestureState private var location: CGPoint?
    @State private var startPoint: CGPoint?
    
    
    var body: some View {
        VStack {
            Button("Close") {
                dismiss()
            }
            GeometryReader { geo in 
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geo.size.height/2))  
                    path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height/2))
                }
                .stroke(lineWidth: 2.0)
                .foregroundStyle(.tertiary)
                ZStack {
                    
                    ForEach(0..<segments.count, id: \.self) { i in 
                        
                        Path { path in
                            path.move(to: segments[i].start)
                            path.addLine(to: segments[i].end)
                        }    
                        .stroke(style: StrokeStyle(lineWidth: 3.0,lineCap: .round))
                        .foregroundStyle(.secondary)
                        .onLongPressGesture {
                            segments.remove(at: i)
                            
                        }
                        
                        Circle()
                            .foregroundStyle(.blue)
                            .frame(width: 15.0, height: 15.0)
                            .padding()
                            .position(segments[i].start)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        segments[i].start = value.location
                                        if let nearPoint = getNearPoint(i: i, currentP: segments[i].start)
                                        {
                                            segments[i].start = nearPoint
                                        }
                                    },
                                including: .all
                            )
                        
                        
                        Circle()
                            .frame(width: 15.0, height: 15.0)
                            .foregroundStyle(.green)
                            .position(segments[i].end)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        segments[i].end = value.location 
                                        if let nearPoint = getNearPoint(i: i, currentP: segments[i].end)
                                        {
                                            segments[i].end = nearPoint
                                        }
                                    },
                                including: .all
                            )
                    }
                    
                    
                    Path { path in
                        if let unwrappedStartPoint = startPoint, let location = location {
                            path.move(to: unwrappedStartPoint)
                            path.addLine(to: location)
                        }
                    }
                    .stroke(style: StrokeStyle(lineWidth: 3.0,lineCap: .round))
                    .foregroundStyle(.secondary)
                    
                    
                    
                }
                .contentShape(Rectangle())
                .gesture(
                    DragGesture()
                        .updating($location) { value, state, transaction in 
                            
                            state = value.location
                        }
                        .onChanged { value in
                            if startPoint == nil {
                                startPoint = value.startLocation
                            }
                            
                        }
                        .onEnded { value in
                            segments.append(Segment(start: value.startLocation, end: value.location))
                            
                            startPoint = nil
                            
                        }
                    
                    
                    , including: .all
                )
                
            }
        }
    }
}
extension FBSettingView3 {
    func getNearPoint(i: Int, currentP: CGPoint) -> CGPoint? {
        let currentSegmentsID = segments[i].id
        let segmentsRemovedI = segments.filter { 
            $0.id != currentSegmentsID
        }
        let points = segmentsRemovedI.map { $0.start } + segmentsRemovedI.map { $0.end }
        return points.filter { $0.getDistance(to: currentP) < 15.0}
            .sorted(by: { $0.getDistance(to: currentP) < $1.getDistance(to: currentP) })
            .first
    }
 
}


