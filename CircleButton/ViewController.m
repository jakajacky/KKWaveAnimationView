//
//  ViewController.m
//  CircleButton
//
//  Created by Li Kelin on 16/11/9.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "KKWaveAnimationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  KKWaveAnimationView *wave = [[KKWaveAnimationView alloc] initWithFrame:CGRectMake(100, 100, 100, 90)];
  wave.waveColor = [UIColor cyanColor];
  wave.waveSize = 0.3;
  wave.waveSpeed = 1;
  [self.view addSubview:wave];
  
  [wave animateWithAttach:[UIImage imageNamed:@"beau.png"] handler:^{
    NSLog(@"点我啦");
  }];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];

}

@end
