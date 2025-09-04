import SwiftUI

struct NavigationHome: View {
    @State private var navigationSelection: NavigationState.ID? 
    private let navigationSelections: [NavigationState] = [.kochCurve, .fractalBranch]
    enum NavigationState: CaseIterable, Identifiable {
        case kochCurve, fractalBranch
        var string: String {
            switch self {
            case .kochCurve: return "Koch Curve"
            case .fractalBranch: return "Fractal Branch"
            }
        }
        var id: Int {
            switch self {
            case .kochCurve: 0
            case .fractalBranch: 1
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(navigationSelections, id: \.id, selection: $navigationSelection) { state in
                Text(state.string)    
            }
            .navigationSplitViewColumnWidth(200.0)
            .navigationTitle("Fractal")
        } detail: {
            if let selection = navigationSelection {
                switch selection {
                case 0: ContentView().environmentObject(Model())
                case 1: FractalBranchView()
                default: EmptyView()
                }
            } else {
                Text("Select a View")
            }
        }
        
    }
}

#Preview {
    NavigationHome()
}
