//
//  File.swift
//  Koch Curve
//
//  Created by 田中悠元 on 2025/09/05.
//

import Foundation

struct FractalBranchPreset: Identifiable {
    let id = UUID()
    let name: String
    let branchConfigs: [BranchConfig]
    func getSegments(parent: Segment) -> [Segment] {
        branchConfigs.map {
            Segment(start:
                        
                        parent.end.scaleRotated(
                            ratio: $0.start.ratio,
                            angle: $0.start.angle,
                            centerPoint: parent.start),
                    end:
                        parent.end.scaleRotated(
                            ratio: $0.end.ratio,
                            angle: $0.end.angle,
                            centerPoint: parent.start)
            )}
    }
    
    static let presets = [
        FractalBranchPreset(name: "コッホ曲線", branchConfigs:
                                [
                                    ((0.0,0.0),(0.333,0.0)),
                                    ((0.333,0.0),(0.577,-CGFloat.pi/6.0)),
                                    ((0.577,-CGFloat.pi/6.0),(0.666,0.0)),
                                    ((0.666,0.0),(1.0,0.0))
                                ]
            .map { BranchConfig(start: $0.0, end: $0.1) }),
        FractalBranchPreset(name: "カントール集合", branchConfigs:
                                [
                                    ((0.0,0.0),(0.333,0.0)),
                                    ((0.6666,0.0),(1.0,0.0))
                                ]
            .map { BranchConfig(start: $0.0, end: $0.1) }),
    FractalBranchPreset(name: "三角形", branchConfigs:
                            [
                                ((0.5773,CGFloat.pi/6.0),(0.2886,-CGFloat.pi/6.0)),
                                ((0.2886,-CGFloat.pi/6.0),(0.7637,-0.19)),
                                ((0.7637,-0.19),(0.5773,CGFloat.pi/6.0))
                            ]
        .map { BranchConfig(start: $0.0, end: $0.1) }),
        FractalBranchPreset(name: "花火", branchConfigs:
                                [
                                    ((0.4,0.0),(0.18,0.0)),
                                    ((0.435,-0.16),(0.355,-0.69)),
                                    ((0.51,-0.2),(0.5936,-0.569)),
                                    ((0.575,-0.12),(0.7607,-0.302)),
                                    ((0.6,0.0),(0.82,0.0)),
                                    ((0.575,0.12),(0.7607,0.302)),
                                    ((0.51,0.2),(0.5936,0.569)),
                                    ((0.435,0.16),(0.355,0.69)),
                                    ((0.358,-1.355),(0.403,-1.256)),
                                    ((0.96,-0.293),(0.969,-0.251)),
                                    ((0.285,1.19),(0.3975,1.21)),
                                    ((0.8957,0.421),(0.9763,0.347)),
                                    ((0.48,0.03),(0.53,-0.03))
                                ]
            .map { BranchConfig(start: $0.0, end: $0.1) }),
        FractalBranchPreset(name: "矩形波", branchConfigs:
                                [
                                    ((0.0,0.0),(0.25,0.0)),
                                    ((0.25,0.0),(0.353,-CGFloat.pi/4.0)),
                                    ((0.353,-CGFloat.pi/4.0),(0.559,-0.463)),
                                    ((0.559,-0.463),(0.559,0.463)),
                                     ((0.559,0.463),(0.79,0.321)),
                                    ((0.79,0.321),(0.75,0.0)),
                                    ((0.75,0.0),(1.0,0.0))
                                ]
            .map { BranchConfig(start: $0.0, end: $0.1) }),
        FractalBranchPreset(name: "木", branchConfigs:
                                [
                                    ((0.0,0.0),(0.5,0.0)),
                                    ((0.5,0.0),(0.6,-0.585)),
                                    ((0.6,-0.585),(0.5,0.0)),
                                    ((0.5,0.0),(1.0,0.0))
                                ]
            .map { BranchConfig(start: $0.0, end: $0.1) }),
        FractalBranchPreset(name: "ドラゴン曲線", branchConfigs:
                                [
                                    ((0.0,0.0),(0.707,-CGFloat.pi/4.0)),
                                    ((1.0,0.0),(0.707,-CGFloat.pi/4.0))
                                ]
            .map { BranchConfig(start: $0.0, end: $0.1) })
    ]
    
}
