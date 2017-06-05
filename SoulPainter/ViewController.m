//
//  ViewController.m
//  SoulPainter
//
//  Created by QiuPeng on 2017/6/5.
//  Copyright © 2017年 bmcciscoding. All rights reserved.
//

#import "ViewController.h"


#import "SPPaintView.h"

@interface ViewController ()

@property (nonatomic, strong) SPPaintView *paintBoard;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SPPaintView *view = [[SPPaintView alloc] initWithFrame:CGRectMake(0,
                                                                      40,
                                                                      CGRectGetWidth(self.view.bounds),
                                                                      CGRectGetHeight(self.view.bounds))];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    self.paintBoard = view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self.paintBoard undo];
}

- (IBAction)resume:(id)sender {
    [self.paintBoard redo];
}

- (IBAction)saveImageToAlbum:(id)sender {
    [self.paintBoard saveImageToAlbum];
}

- (IBAction)resetBtn:(id)sender {
    [self.paintBoard reset];
}


@end
