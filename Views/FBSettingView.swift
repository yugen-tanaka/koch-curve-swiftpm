import SwiftUI

struct FBSettingView: View {
    @EnvironmentObject var model: Model
    @State private var segments : [Segment] = []
    @State private var points: [CGPoint] = .init()
    @State private var mode = false
    @State private var isEnd = false
    @State private var startPoint: CGPoint?
    
    
    
    var body: some View {
        VStack {
            Toggle(isOn: $mode, label: {
                Text("モード")
            })
            ZStack {
                if mode {
                    ForEach(segments) { segment in
                        Path { path in
                            path.move(to: segment.start)
                            path.addLine(to: segment.end)
                        }    
                        .stroke(lineWidth: 1.0)
                        .contextMenu(ContextMenu(menuItems: {
                            Text("Reverse")
                            Text("Delete")
                        }))
                    }
                    ForEach(points, id: \.x) { point in
                        Circle()
                            .frame(width: 10.0, height: 10.0)
                            .foregroundStyle(point == startPoint ? .red : .green)
                            .position(point)
                            .onTapGesture {
                                isEnd.toggle()
                                if isEnd  {
                                    if point != startPoint {
                                        if let unwrappedStartPoint = startPoint {
                                            segments.append(Segment(start: unwrappedStartPoint, end: point))
                                        }
                                        
                                    }
                                    startPoint = nil
                                } else {
                                    startPoint = point
                                    
                                }
                            }
                    }
//                    Path { path in
//                        for segment in segments {
//                            path.move(to: segment.start)
//                            path.addLine(to: segment.end)
//                        }
//                    }
//                    .stroke(lineWidth: 1.0)
//                    
//                    ForEach(0..<segments.count, id: \.self) { index in
//                        Circle()
//                            .foregroundStyle(.red)
//                            .frame(width: 10.0, height: 10.0)
//                            .position(segments[index].start)
//                            .gesture(
//                                DragGesture()
//                                    .onChanged { value in
//                                        segments[index].start = value.location
//                                    }
//                            )
//                        Circle()
//                            .foregroundStyle(.green)
//                            .frame(width: 10.0, height: 10.0)
//                            .position(segments[index].end)
//                            .gesture(
//                                DragGesture()
//                                    .onChanged { value in
//                                        if value.location.getDistance(to: segments[index+1].start) < 50.0 {
//                                            segments[index].end = segments[index+1].start
//                                        } else {
//                                            segments[index].end = value.location
//                                        }
//                                    }
//                            )
//                    }
                } else {
                    Rectangle()
                        .frame(width: .infinity, height: .infinity)
                        .foregroundStyle(.background)
                        .onTapGesture(coordinateSpace: .local) { location in
                            self.points.append(location) 
                        }
                    ForEach(points, id: \.x) { point in
                        Circle()
                            .frame(width: 10.0, height: 10.0)
                            .foregroundStyle(.green)
                            .position(point)
                    }    
                }
                
                
            }
            
            Text("SBSettingView")
        }
    }
}

#Preview {
    
    FBSettingView()
        .environmentObject(Model())
}
