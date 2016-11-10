//
//  KKWaveAnimationView.h
//  CircleButton
//
//  Created by Li Kelin on 16/11/9.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WhenDidClickWave)();

@interface KKWaveAnimationView : UIView
@property (nonatomic, strong) UIColor *waveColor;  // default is RedColor
@property (nonatomic, assign) CGFloat waveSize;    // [0...1] default 0.5
@property (nonatomic, assign) CGFloat waveSpeed;   // [0...1] default 0.5
- (void)animateWithAttach:(UIImage *)attach handler:(WhenDidClickWave)handler;
@end
