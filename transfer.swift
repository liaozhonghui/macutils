#!/usr/bin/env xcrun swift
import Foundation

let url =  URL(fileURLWithPath: "/Users/xinliao/Projects/ToolProjects/macemoji/phrases.ini")
let targetUrl =  URL(fileURLWithPath: "/Users/xinliao/Downloads/搜狗输入法配置.plist")
let content = try Data(contentsOf: url)
let string = String(data: content, encoding: .unicode)
let dic = string!
    .components(separatedBy: "$$")
    .map { $0.replacingOccurrences(of: "\r\n", with: "")}
    .map { ($0.split(separator: "=").first?.split(separator: ",").first, $0.split(separator: "=").last) }
    .filter { $0.0 != nil && $0.1 != nil }
    .map { [
        "shortcut": $0.0!,
        "phrase": $0.1!
    ] }

let xml = try PropertyListSerialization.data(fromPropertyList: dic, format: .xml, options: 0)
try xml.write(to: targetUrl)

print(dic.count)
