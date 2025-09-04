import SwiftUI

struct NumberSetting: View {
    @EnvironmentObject var model: Model
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("r1: ")
                    TextField("r1", value: $model.r1, format: .number)
                }
                HStack {
                    Text("r2: ")
                    TextField("r2", value: $model.r2, format: .number)
                }
                HStack {
                    Text("r3: ")
                    TextField("r3", value: $model.r3, format: .number)
                }
            } header: {
                Text("ratio")
            }
            Section {
                HStack {
                    Text("angle1: ")
                    TextField("angle1", value: $model.angle1, format: .number)
                }
                HStack {
                    Text("angle2: ")
                    TextField("angle2", value: $model.angle2, format: .number)
                }
                HStack {
                    Text("angle3: ")
                    TextField("angle3", value: $model.angle3, format: .number)
                }
            } header: {
                Text("Angle")
            }
                
        }
    }
}
