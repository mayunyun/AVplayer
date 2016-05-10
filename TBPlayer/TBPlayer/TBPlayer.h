//
//  TBPlayer.h
//  TBPlayer
//
//  Created by qianjianeng on 16/1/31.
//  Copyright © 2016年 SF. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
/*
 *添加横纵屏
 */
#import "UIWindow+YzdHUD.h"
#define UISCREEN_WIDTH      MIN([UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)
#define UISCREEN_HEIGHT     MAX([UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)


FOUNDATION_EXPORT NSString *const kTBPlayerStateChangedNotification;
FOUNDATION_EXPORT NSString *const kTBPlayerProgressChangedNotification;
FOUNDATION_EXPORT NSString *const kTBPlayerLoadProgressChangedNotification;

//播放器的几种状态
typedef NS_ENUM(NSInteger, TBPlayerState) {
    TBPlayerStateBuffering = 1,
    TBPlayerStatePlaying   = 2,
    TBPlayerStateStopped   = 3,
    TBPlayerStatePause     = 4
};

@interface TBPlayer : NSObject

@property (nonatomic, readonly) TBPlayerState state;
@property (nonatomic, readonly) CGFloat       loadedProgress;   //缓冲进度
@property (nonatomic, readonly) CGFloat       duration;         //视频总时间
@property (nonatomic, readonly) CGFloat       current;          //当前播放时间
@property (nonatomic, readonly) CGFloat       progress;         //播放进度 0~1
@property (nonatomic          ) BOOL          stopWhenAppDidEnterBackground;// default is YES



/*
 *添加
 */
@property (assign, nonatomic) BOOL isFullscreen;                             //是否横屏
@property (assign, nonatomic) UIInterfaceOrientation currentOrientation;     //当前屏幕方向
@property (strong, nonatomic) NSLayoutConstraint *vcBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *playerCenterXContraint;
@property (strong, nonatomic) NSLayoutConstraint *playerHeightContraint;
@property (strong, nonatomic) NSLayoutConstraint *danmuBottomContraint;
@property (strong, nonatomic) NSArray *playerContraints;
/**
 *  竖屏的时候播放器高度
 */
@property (assign, nonatomic) float portraitViewHeight;
/**
 *  是否支持播放器自动旋转(改变设备物理方向，自动改变播放器画面)
 */
@property (assign, nonatomic) BOOL supportAutomaticRotation;
/**
 *  是否支持角度旋转协议(支持表示播放画面会随着推流端旋转而旋转)
 */
@property (assign, nonatomic) BOOL supportAngleChange;


+ (instancetype)sharedInstance;
- (void)playWithUrl:(NSURL *)url showView:(UIView *)showView;
- (void)seekToTime:(CGFloat)seconds;

- (void)resume;
- (void)pause;
- (void)stop;

- (void)fullScreen;  //全屏
- (void)halfScreen;   //半屏
//屏幕旋转的方法
- (void)awakeSupportInterOrtation:(UIViewController *)showVC completion:(void(^)(void))block;



@end
