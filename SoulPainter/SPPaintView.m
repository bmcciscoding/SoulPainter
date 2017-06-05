//
//  SPPaintView.m
//  SoulPainter
//
//  Created by QiuPeng on 2017/6/5.
//  Copyright © 2017年 bmcciscoding. All rights reserved.
//

#import "SPPaintView.h"

@interface SPPaintView ()

@property (nonatomic, strong) NSMutableArray *undoStep;
@property (nonatomic, strong) NSMutableArray *redoStep;
@property (nonatomic, strong) CAShapeLayer *paper;
@property (nonatomic, strong) UIBezierPath *pen;

@end

@implementation SPPaintView

#pragma mark - Life Cycle

- (void)dealloc {
    self.undoStep = nil;
    self.redoStep = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.undoStep = @[].mutableCopy;
        self.redoStep = @[].mutableCopy;
        
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - Func
- (void)reset {
    [self.undoStep enumerateObjectsUsingBlock:^(CALayer *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    [self.undoStep removeAllObjects];
    [self.redoStep removeAllObjects];
}

- (void)undo {
    if (self.undoStep.count == 0) {
        return;
    }
    CALayer *layer = self.undoStep.lastObject;
    [self.undoStep removeObject:layer];
    
    [self.redoStep addObject:layer];
}

- (void)redo {
    if (self.redoStep.count == 0) {
        return;
    }
    CALayer *layer = self.redoStep.lastObject;
    [self.redoStep removeObject:layer];
    [self.layer addSublayer:layer];
    [self.undoStep addObject:layer];
}

- (void)saveImageToAlbum {
    UIImage *image = [self saveImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (UIImage *)saveImage {
    
    if (self.undoStep.count == 0) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Event
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.layer addSublayer:self.paper];
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    [self.pen moveToPoint:location];
    self.paper.path = self.pen.CGPath;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    NSLog(@"%@", NSStringFromCGPoint(location));
    [self.pen addLineToPoint:location];
    self.paper.path = self.pen.CGPath;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.undoStep addObject:self.paper];
    self.paper = nil;
    self.pen = nil;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.paper removeFromSuperlayer];
}
#pragma mark - Getter
- (CAShapeLayer *)paper {
    if (_paper == nil) {
        _paper = [CAShapeLayer layer];
        _paper.fillColor = [UIColor clearColor].CGColor;
        _paper.strokeColor = self.paintColor.CGColor ?: [UIColor blackColor].CGColor;
        _paper.lineCap = kCALineCapRound;
        _paper.lineJoin = kCALineCapRound;
        _paper.lineWidth = self.paintWidth > 0 ? self.paintWidth : 0.3;
    }
    return _paper;
}

- (UIBezierPath *)pen {
    if (_pen == nil) {
        _pen = [UIBezierPath bezierPath];
        _pen.lineCapStyle = kCGLineCapRound;
        _pen.lineJoinStyle = kCGLineCapRound;
    }
    return _pen;
}

@end
