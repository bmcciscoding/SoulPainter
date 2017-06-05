# SoulPainter
灵魂画家

## 一个简单的绘图的view 0.0.1版本
- 画笔的颜色
- 画笔的宽度
- 撤销
- 反撤销
- 清屏
## 使用
``` objective-c
@interface SPPaintView : UIView

@property (nonatomic, strong) UIColor *paintColor;
@property (nonatomic, assign) CGFloat paintWidth;

- (void)reset;
- (void)undo;
- (void)redo;
- (void)saveImageToAlbum;
- (UIImage *)saveImage;

@end

```
