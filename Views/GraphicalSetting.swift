import SwiftUI

struct GraphicalSetting: View {
    @EnvironmentObject var model: Model
    @State private var previousSettingPoints:[CGPoint] = []
    var body: some View {
        VStack {
            GeometryReader { geo in
                
                if !model.settingPoints.isEmpty {
                    
                    
                    Path { path in
                        path.move(to: model.settingPoints.first!)
                        
                        for point in model.settingPoints.dropFirst() {
                            path.addLine(to: point)
                        }
                    }    
                    .stroke(lineWidth: 2.0)
                    
                    
                    ForEach(1..<model.settingPoints.count-1, id: \.self) { index in
                        Circle()
                            .frame(width: 7.0)
                            .padding(5.0)
                            .position(x: model.settingPoints[index].x, y: model.settingPoints[index].y)
                            .foregroundStyle(Color.red)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let x = value.location.x
                                        let y = value.location.y
                                        let xCondition = x > 10.0 && x < geo.size.width - 10.0
                                        let yCondition = y > 10.0 && y < geo.size.height - 10.0
                                        if xCondition && yCondition {
                                            model.settingPoints[index] = value.location
                                        } else if !xCondition && yCondition {
                                            model.settingPoints[index].y = y
                                        } else if !yCondition && xCondition {
                                            model.settingPoints[index].x = x
                                        }
                                    }
                            )
                    }
                    VStack(alignment: .center) {
                        Spacer()
                        Button {
                            model.generateSettingPoints(startPoint: CGPoint(x: 0.0, y: geo.size.height / 2.0), endPoint: CGPoint(x: geo.size.width, y: geo.size.height/2.0))
                        } label: {
                            Label("Reset", systemImage: "arrow.clockwise")
                        }
                    }
                    
                } else {
                    Text("SettingPoint has no value")
                        .onAppear {
                            model.generateSettingPoints(startPoint: CGPoint(x: 0.0, y: geo.size.height / 2.0), endPoint: CGPoint(x: geo.size.width, y: geo.size.height/2.0))
                        }
                    
                }
            }
            .padding(0.0)
            
        }
    
    }
    
}

#Preview {
    GraphicalSetting()
        .environmentObject(Model())
}
