//
//  LiquidButton.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-18.
//
import Foundation
import UIKit
import SwiftUI

class LiquidButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLiquidGlass()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented!")
    }

    private func setupLiquidGlass() {
        configuration = .glass()
        setTitle("Button", for: .normal)
    }
}

#Preview {
    LiquidButtonPreview()
}

struct LiquidButtonPreview: UIViewRepresentable {

    func makeUIView(context: Context) -> LiquidButton {
        LiquidButton(frame: .zero)
    }

    func updateUIView(_ uiView: LiquidButton, context: Context) {
    }
}
