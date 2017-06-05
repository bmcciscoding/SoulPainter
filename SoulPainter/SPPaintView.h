//
//  SPPaintView.h
//  SoulPainter
//
//  Created by QiuPeng on 2017/6/5.
//  Copyright © 2017年 bmcciscoding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPPaintView : UIView

@property (nonatomic, strong) UIColor *paintColor;
@property (nonatomic, assign) CGFloat paintWidth;
@property (nonatomic, strong) UIImage *customPenHeader;

- (void)reset;
- (void)undo;
- (void)redo;
- (void)saveImageToAlbum;
- (UIImage *)saveImage;

@end
