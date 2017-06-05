# SoulPainter
灵魂画家

## 一个简单的绘图的 view，使用 CAShapeLayer + UIBezierPath 实现
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
