// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#elseif os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#endif

extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

enum ColorName {
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f8f5f5"></span>
  /// Alpha: 100% <br/> (0xf8f5f5ff)
  case Background
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ededed"></span>
  /// Alpha: 100% <br/> (0xedededff)
  case Border
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#179a38"></span>
  /// Alpha: 100% <br/> (0x179a38ff)
  case Green
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e75057"></span>
  /// Alpha: 100% <br/> (0xe75057ff)
  case LeftOverlay
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e75057"></span>
  /// Alpha: 100% <br/> (0xe75057ff)
  case Red
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#179a38"></span>
  /// Alpha: 100% <br/> (0x179a38ff)
  case RightOverlay
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#df3845"></span>
  /// Alpha: 100% <br/> (0xdf3845ff)
  case Salmon
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#dddddd"></span>
  /// Alpha: 100% <br/> (0xddddddff)
  case Shadow
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#df3845"></span>
  /// Alpha: 100% <br/> (0xdf3845ff)
  case Theme

  var rgbaValue: UInt32 {
    switch self {
    case .Background: return 0xf8f5f5ff
    case .Border: return 0xedededff
    case .Green: return 0x179a38ff
    case .LeftOverlay: return 0xe75057ff
    case .Red: return 0xe75057ff
    case .RightOverlay: return 0x179a38ff
    case .Salmon: return 0xdf3845ff
    case .Shadow: return 0xddddddff
    case .Theme: return 0xdf3845ff
    }
  }

  var color: Color {
    return Color(named: self)
  }
}

extension Color {
  convenience init(named name: ColorName) {
    self.init(rgbaValue: name.rgbaValue)
  }
}
