/*Swift 常用声明*/
import UIKit
import Then
import Foundation
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let deviceUUID = UIDevice.current.identifierForVendor?.uuidString
extension UIColor {
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat ,_ a: CGFloat) -> UIColor {
        return UIColor.init(red: r / 255, green: g / 255, blue: b / 255,alpha: a)
    }
    convenience init(hexString:String){
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回whiteColor
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
}
//取数据的key
let ZToken = "access_token"
let ZDept = "dept"
let Zduty = "duty"
let ZrealName = "realName"
let Zcode = "code"
//存数据
func UserDefaultSave(Key:String,Value:Any?) {
    UserDefaults().set(Value, forKey: Key)
}
//取数据
func UserDefauTake(Key:String) -> Any? {
    return UserDefaults().object(forKey: Key)
}
//删除数据
func UserDefaultRemove(Key:String) {
    UserDefaults().removeObject(forKey: Key)
}

//获取当前时间
func CurrentDate() -> String {
    let date = NSDate()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy-MM-dd"
    let strNowTime = timeFormatter.string(from: date as Date) as String
    return strNowTime
}

//UI工厂
class CreateUI {
    //标签
    class func Label(textColor : UIColor , backgroundColor : UIColor , title : String , frame : CGRect , font : Int) -> UILabel {
        return UILabel().then{
            $0.textColor = textColor;
            $0.backgroundColor = backgroundColor;
            $0.text = title;
            $0.frame = frame
            $0.font =  UIFont.systemFont(ofSize: CGFloat(font))
        }
    }
    //按钮
    class func Button(title:String, frame : CGRect, backgroundColor : UIColor ,textColor : UIColor, font : Int)->UIButton {
        return UIButton(type: .custom).then{
            $0.frame = frame
            $0.backgroundColor = backgroundColor
            $0.setTitle(title, for:.normal)
            $0.setTitleColor(textColor, for: .normal)
            $0.titleLabel!.font = UIFont.systemFont(ofSize: CGFloat(font))
        }
    }
    //文本框
    class func TextField(placeholder:String, frame : CGRect , backgroundColor : UIColor , textColor : UIColor, sender:UIViewController) -> UITextField {
        return UITextField(frame: frame).then{
            $0.backgroundColor = backgroundColor
            $0.textColor = textColor
            $0.placeholder = placeholder
            $0.borderStyle = UITextBorderStyle.roundedRect
            $0.adjustsFontSizeToFitWidth = true
        }
    }
    //分段
    class func Segment(_ items: [String],frame : CGRect) ->UISegmentedControl {
        return UISegmentedControl(items:items).then{
            $0.frame = frame
            $0.isMomentary = false
        }
    }
}
