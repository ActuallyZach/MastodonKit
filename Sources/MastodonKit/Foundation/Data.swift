//
//  Data.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension Data {
    init?(mediaAttachment: MediaAttachment) {
        guard let mediaData = mediaAttachment.data else { return nil }

        self.init()

        append("--MastodonKitBoundary\r\n")
        append("Content-Disposition: form-data; name=\"file\"; filename=\"\(mediaAttachment.fileName)\"\r\n")
        append("Content-Type: \(mediaAttachment.mimeType)\r\n\r\n")
        append(mediaData)
        append("\r\n")
        append("--MastodonKitBoundary--\r\n")
    }
    
    init(parameters: [Parameter]) {
        self.init()

        for parameter in parameters {
            append(.init(parameter: parameter))
        }
    }
    
    init(parameter: Parameter) {
        self.init()

        if let parameterValue = parameter.value {
            append("--MastodonKitBoundary\r\n")
            append("Content-Disposition: form-data; name=\"\(parameter.name)\"\r\n")
            append("\r\n")
            append(parameterValue)
            append("--MastodonKitBoundary\r\n")
        }
    }

    mutating func append(_ string: String?) {
        guard let data = string?.data(using: .utf8) else { return }
        append(data)
    }
}
