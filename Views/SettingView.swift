import SwiftUI

struct SettingView: View {
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    @State private var selection: SettingSelection = .graphic
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $selection) {
                ForEach(SettingSelection.allCases, id: \.self) { i  in
                    Text(i.text)    
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 300)
            .padding(.horizontal)
            SelectedSetting(selection: $selection)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            model.savePattern()
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", role: .cancel) {
                            dismiss()
                        } 
                        
                    }
                }
        }
    }
    
    
}

struct SelectedSetting: View {
    @Binding var selection: SettingSelection
    @EnvironmentObject var model: Model
    
    var body: some View {
        if selection == .graphic {
            VStack {
                Spacer()
                GraphicalSetting()
                    .frame(width: 500, height: 500)
                Spacer()
            }
        } else if selection == .number {
            NumberSetting()
        } else {
            Text("Error!")
        }
    }
}

enum SettingSelection: Hashable, CaseIterable {
    case graphic 
    case number 
    
    var id: Int {
        switch self {
        case .graphic: return 0
        case .number: return 1
        }
    }
    var text: String {
        switch self {
        case .graphic: return "Graphic"
        case .number: return "Number"
        }
    }
}

#Preview {
    SettingView()
        .environmentObject(Model())
}
