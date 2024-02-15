//
//  ContentView.swift
//  CustomCodeInput
//
//  Created by 香饽饽zizizi on 2024/2/10.
//

import SwiftUI

struct ContentView: View {
    @State private var code: String = ""
    @FocusState private var isKeyboardShowing: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 50.0) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("输入验证码")
                        .font(.title2.bold())
                        .foregroundStyle(.primary)

                    Text("验证码已发送至 +86 13800000000")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 10.0) {
                    ForEach(0..<4, id: \.self) { index in
                        OTPTextView(index)
                    }
                }
                .background {
                    TextField(text: $code) {
                        Text("请输入验证码")
                    }
                    .frame(width: 0, height: 0)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .focused($isKeyboardShowing)
                    .onChange(of: code) { _, newValue in
                        if newValue.count > 4 {
                            code = String(newValue.prefix(4))
                        }
                    }
                }
                .onTapGesture {
                    isKeyboardShowing = true
                }

                Button {

                } label: {
                    Text("登录")
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(.blue, in: .capsule)
                }

            }
            .padding()
        }
        .scrollDismissesKeyboard(.immediately)
    }

    @ViewBuilder
    func OTPTextView(_ index: Int) -> some View {
        let status = (isKeyboardShowing && code.count == index)

        ZStack {
            Group {
                if code.count > index {
                    let charIndex = code.index(code.startIndex, offsetBy: index)
                    let str = String(code[charIndex])
                    Text(str)
                } else {
                    Text(" ")
                }
            }
            .font(.title.bold())
        }
        .frame(width: 45, height: 45)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(status ? Color.black : Color.gray)
                .frame(height: 2)
        }
    }
}

#Preview {
    ContentView()
}
