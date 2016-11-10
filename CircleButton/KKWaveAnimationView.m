//
//  KKWaveAnimationView.m
//  CircleButton
//
//  Created by Li Kelin on 16/11/9.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//


#define kTransformScaleOne @"com.ideabinder.tranformScaleOne"
#define kTransformScaleTwo @"com.ideabinder.tranformScaleTwo"

#import "KKWaveAnimationView.h"

@interface KKWaveAnimationView ()
@property (nonatomic, strong) UIImageView *mainView;
@property (nonatomic, strong) UIImageView *wave1;
@property (nonatomic, strong) UIImageView *wave2;
@property (nonatomic, copy) WhenDidClickWave clickMainView;
@end
@implementation KKWaveAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _waveColor = [UIColor redColor];
    _waveSize  = 0.5;
    _waveSpeed = 0.5;
  }
  return self;
}


- (UIImageView *)viewWithFrame:(CGRect)frame
{
  UIImageView *wave = [[UIImageView alloc] initWithFrame:frame];
  CGFloat value = frame.size.width;
  wave.backgroundColor = _waveColor;
  wave.layer.cornerRadius = value/2;
  wave.userInteractionEnabled = YES;
  wave.layer.masksToBounds = YES;
  wave.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  return wave;
}

- (void)viewName:(UIView *)view animaKey:(NSString *)key
{
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
  animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.01, 1.01, 1.0)];
  animation.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5 + _waveSize, 1.5 + _waveSize, 1.0)];
  
  CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
  alphaAnim.fromValue = @(1);
  alphaAnim.toValue   = @(0);
  
  CAAnimationGroup *group = [CAAnimationGroup animation];
  group.animations = [NSArray arrayWithObjects:animation,alphaAnim, nil];
  group.removedOnCompletion = YES;
  group.fillMode = kCAFillModeForwards;
  group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  group.duration = 1.5/(_waveSpeed);
  group.repeatCount = HUGE_VALF;
  [view.layer addAnimation:group forKey:key];
}

- (void)animateWithAttach:(UIImage *)attach handler:(WhenDidClickWave)handler
{
  if (attach) {
    _mainView.image = attach;
  }
  self.clickMainView = handler;
}

- (void)didMoveToSuperview
{
  [super didMoveToSuperview];
  [self correctValue];
  [self layoutViews];
  [self addTargets];
  [self startAnimation];
}

- (void)correctValue
{
  if (self.waveSpeed <= 0) {
    _waveSpeed = 0.0000001;
  }
  
  if (self.waveSpeed >= 1) {
    _waveSpeed = 1;
  }
  
  if (self.waveSize <= 0) {
    _waveSize = 0;
  }
  
  if (self.waveSize > 1) {
    _waveSize = 1;
  }
}

- (void)layoutViews
{
  CGFloat w = self.bounds.size.width;
  CGFloat h = self.bounds.size.height;
  CGFloat min = MIN(w, h);
  
  CGRect rect = CGRectMake(0, 0, min, min);
  _mainView = [self viewWithFrame:rect];
  _wave1 = [self viewWithFrame:rect];
  _wave2 = [self viewWithFrame:rect];
  
  [self addSubview:_wave1];
  [self addSubview:_wave2];
  [self addSubview:_mainView];
}

- (void)addTargets
{
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(whenClickMain)];
  [_mainView addGestureRecognizer:tap];
}

- (void)whenClickMain
{
  if (self.clickMainView) {
    self.clickMainView();
  }
}


- (void)startAnimation
{
  [self viewName:_wave1 animaKey:kTransformScaleOne];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1.5/(_waveSpeed)) * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self viewName:_wave2 animaKey:kTransformScaleTwo];
  });
}

@end
