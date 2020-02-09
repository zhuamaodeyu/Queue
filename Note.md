
1. alert 样式显示window  

```
self?.view.window?.beginSheet(windowController.window!, completionHandler: { (modeResponse) in

})
```

2. window 中的NSTextField 无法响应用户s事件  
    查看是否可以成为第一响应者  
```
class KeyWindow: NSWindow {

override var canBecomeKey: Bool {
get {
return true 
}
}
}
```
3. 抗压缩和抗拉伸  

```
// 抗拉伸
addressLabel.setContentHuggingPriority(.required, for: .horizontal)
// 抗k压缩
//        addressLabel.setContentCompressionResistancePriority(.required, for: .vertical)

```

4. 设置字体，导致不可编辑 

```
// 不设置字体，导致不可编辑
//        addressTextField.font = NSFont.init(name: "", size: 15.0)
addressTextField.focusRingType = .none //选中高亮边框
```

5. button 状态 

```
 self.tagRadioButton.state = .on

```

6. 通知  

```
https://blog.gaelfoppolo.com/user-notifications-in-macos-66c25ed5c692 

let notification = NSUserNotification()
notification.identifier = "unique-id"
notification.title = "Hello"
notification.subtitle = "How are you?"
notification.informativeText = "This is a test"
notification.soundName = NSUserNotificationDefaultSoundName
//        notification.contentImage = NSImage(contentsOf: NSURL(string: "https://placehold.it/300")! as URL)
// Manually display the notification

// 延迟10 🐱 scheduleNotification 发送通知
notification.deliveryDate = NSDate(timeIntervalSinceNow: 10)
let notificationCenter = NSUserNotificationCenter.default
notificationCenter.scheduleNotification(notification)
// 发送通知
//        notificationCenter.deliver(notification)
// 默认情况下  如果当前应用处于第一响应者，则不会显示通知， 只会在通知中心显示通知

// 设置通知重复 (允许的最小时间间隔是一分钟，否则您将遇到运行时错误。)
let repeatInt = NSDateComponents（）
repeatInt.day = 1 
notification.deliveryRepeatInterval = repeatInt 

// 设置自定义占位符 
notification.hasReplyButton = true 
notification.responsePlaceholder =“输入你在这里回复”

// 通过代理方法，获取用户输入的字段 
func userNotificationCenter(center: NSUserNotificationCenter, didActivateNotification notification: NSUserNotification) {
switch (notification.activationType) {
case .Replied:
guard let res = notification.response else { return }
print("User replied: \(res.string)")
default:
break;
}
}

// 强制显示通知 
func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
return true
}

```

7. 自定义 NSControl 鼠标事件 

```
// 重载此方法，手动发送action   
override func mouseDown(with event: NSEvent) {
super.mouseDown(with: event)
sendAction(self.action, to: self.target)
}

```

8. 禁止鼠标事件  

```
descLabel.isEnabled = false
var acceptsTouchEvents: Bool { get set }

```

9. NSTableView 

```
tableContainerView.snp.makeConstraints { (make) in
make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
}
// 此处只能设置 scrollView 约束 不然就会无效
//        tableView.snp.makeConstraints { (make) in
//            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
//        }
```



```
//        print("\(#function)")
//        let cell  = tableView.rowView(atRow: row, makeIfNecessary: false)
//        cell?.selectionHighlightStyle = .regular
//        cell?.isEmphasized = false
//        cell?.backgroundColor = NSColor.randomColor
```

10. NSDocument 
```

////将当前文档保存时调用
//override func data(ofType typeName: String) throws -> Data {
//    //在此处插入代码，将文档写入指定类型的数据，如果失败则抛出错误。
//    //或者，您可以删除此方法并覆盖fileWrapper（ofType :)，write（to：ofType :)或write（to：ofType：for：originalContentsURL :)。
//    throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
//}
////当读取新的数据时调用
//override func read(from data: Data, ofType typeName: String) throws {
//    // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
//    // Alternatively, you could remove this method and override read(from:ofType:) instead.
//    // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
//    throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
//}


```


11. 无边框window默认不能成为第一响应者


12. NSCollectionView cell 可点击  

```
    self.collectionView.isSelectable = true
```
13. NSCollectionView 不可多次点击  


14. 配置cell 的值 
```
//    override var objectValue: Any? {
//        didSet {
//            if let model =  objectValue as? MenuModel {
//                self.iconImageView.image = NSImage.init(named: model.icon)
//                self.titleLabel.stringValue = model.name
//                self.unreadCountView.stringValue = "\(model.unreadCount)"
//                self.unreadCountView.updateLayer()
//                if model.unreadCount == 0 {
//                    self.unreadCountView.isHidden = true
//                }else {
//                    self.unreadCountView.isHidden = false
//                }
//            }
//        }
//    }
//    




```


14. cocoa 动画实现方式  
    * NSViewAnimation  
        主要适用的对象为NSView和NSWindow，它所能定制的动画属性也只限于Frame的改变，和渐显渐稳，
    * NSAnimationContext
        可以通过设置NSView或NSWindow的一些与显示相关的属性来设置动画。 如果需要自定义属性，需要实现一些方法  
    * QuartzCore
        
