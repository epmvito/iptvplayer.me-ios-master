//
//  String.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 12.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

extension String {
    var numberOfWords: Int {
        let inputRange = CFRangeMake(0, utf16.count)
        let flag = UInt(kCFStringTokenizerUnitWord)
        let locale = CFLocaleCopyCurrent()
        let tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault, self as CFString, inputRange, flag, locale)
        var tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)
        var count = 0

        while tokenType != [] {
            count += 1
            tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }
        return count
    }
}
