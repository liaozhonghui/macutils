Mac 下的 phrases.ini 文件

处理过程
使用 shift + command+ option +上下箭头进行选取
在开头增加$$符号

使用 swift 脚本进行文本生成 transfer.swift

```swift
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
```

执行脚本

```bash
Chmod 755 ./transfer.swift
./transfer.swift

```

将生成的搜狗输入法配置.plist 文件拖动到 键盘->文本列表中，键盘->文本可以用 command+😦 全选，可以执行删除操作。

搜狗输入法同步
