//
//  PlayerManager.m
//  UCloudMediaRecorderDemo
//
//  Created by yisanmao on 16/1/4.
//  Copyright © 2016年 zmw. All rights reserved.
//

#import "PlayerManager.h"
#import "UIWindow+YzdHUD.h"
#import "ViewController.h"

#define DateSave @"ufile"
#define UISCREEN_WIDTH      MIN([UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)
#define UISCREEN_HEIGHT     MAX([UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)

#define AlertViewNOBai 100
#define AlertViewSave 101
#define AlertViewSaveSucess 102
#define AlertViewPlayerError 103

@interface PlayerManager()
@property (strong, nonatomic) NSArray *contrants;
@end

@implementation PlayerManager
//- (void)buildPlayer:(NSString *)path
//{
//    [self addNotification];
//    //类似下面这样进行点播
////    path = @"http://mediademo.ufile.ucloud.com.cn/ucloud_promo_140s.mp4";
////    path = @"http://lol.ufile.ucloud.com.cn/696781-100-1453257209.mp4";
//    NSURL *theMovieURL = [NSURL URLWithString:path];
//    self.player = [[UCloudMediaPlayer alloc] init];
////    self.player.urlType = UrlTypeLive;
//    [self.player setUrl:theMovieURL];
//    
//    __weak PlayerManager *weakSelf = self;
//    [self.player showInview:self.view definition:^(NSInteger defaultNum, NSArray *data) {
//        
//        [weakSelf buildMediaControl:defaultNum data:data];
//        [weakSelf configurePlayer];
//
//    }];
//}
//
//- (void)dealloc
//{
//    [self removeNotification];
//}
//
//- (void)configurePlayer
//{
//    //点播默认进来是横屏波放过，直播进来默认是竖屏播放
//    if (self.player.urlType == UrlTypeLive)
//    {
//        self.isFullscreen = YES;
//    }
//    [self clickFull:nil];
//    
//    self.isPortrait = NO;
//    
//    self.vc.view.autoresizingMask = UIViewAutoresizingNone;
//    
//    
//    NSMutableArray *cons = [NSMutableArray array];
//    self.p = [NSMutableArray array];
//    self.l = [NSMutableArray array];
//    [self addConstraintForView:self.player.player.view inView:self.view constraint:cons p:self.p l:self.l];
//    
//    if (self.player.urlType == UrlTypeLive)
//    {
//        //生成新的ijksdlView默认旋转角度
//        [[NSNotificationCenter defaultCenter] postNotificationName:UCloudPlayerVideoChangeRotationNotification object:@(0)];
//    }
//    
//    self.playerContraints = [NSArray arrayWithArray:cons];
//    self.vcBottomConstraint = [self addConstraintForView:self.vc.view inView:self.view constraint:nil];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"view" object:nil];
//}
//
//- (void)addConstraintForView:(UIView *)subView inView:(UIView *)view constraint:(NSMutableArray *)contraints p:(NSMutableArray *)p l:(NSMutableArray *)l
//{
//    //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
//    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
//    
//    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
//    
//    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
//    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
//    
//    NSLayoutConstraint *contraint5 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
//    NSLayoutConstraint *contraint6 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
//    
//    NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, contraint5, contraint6, nil];
//    
//    if (contraints)
//    {
//        [contraints addObjectsFromArray:array];
//    }
//    if (p)
//    {
//        [p addObjectsFromArray:@[contraint3, contraint4]];
//    }
//    if (l)
//    {
//        [l addObjectsFromArray:@[contraint5, contraint6]];
//    }
//    
//    //把约束添加到父视图上
//    [view addConstraints:array];
//    
//    self.contrants = @[contraint5,contraint6];
//    [view removeConstraints:self.contrants];
//    
//    
//    
////    [NSLayoutConstraint deactivateConstraints:@[contraint5, contraint6]];
//    
//    
//    
//    
//    self.playerCenterXContraint = contraint2;
//    self.playerHeightContraint = contraint4;
//}
//
//- (NSLayoutConstraint *)addConstraintForView:(UIView *)subView inView:(UIView *)view constraint:(NSMutableArray *)contraints
//{
//    //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
//    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
//    
//    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
//    
//    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-0.0];
//    //子view的右边缘离父view的右边缘40个像素
//    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-0.0];
//    //把约束添加到父视图上
//    NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, nil];
//    
//    if (contraints)
//    {
//        [contraints addObjectsFromArray:array];
//    }
//    [view addConstraints:array];
//    
//    return contraint3;
//}
//
//- (void)reConfigurePlayer:(CGFloat)current
//{
//    float height = self.playerHeightContraint.constant;
//    float centerX = self.playerCenterXContraint.constant;
//    [self.view removeConstraints:@[self.playerCenterXContraint, self.playerHeightContraint]];
//    
//    self.vc.delegatePlayer = self.player.player;
//    
//    self.player.player.view.frame = self.vc.view.bounds;
//    [self.view addSubview:self.player.player.view];
//    
//    
//    NSMutableArray *cons = [NSMutableArray array];
//    self.p = [NSMutableArray array];
//    self.l = [NSMutableArray array];
//    [self addConstraintForView:self.player.player.view inView:self.view constraint:cons p:self.p l:self.l];
//    self.playerHeightContraint.constant = height;
//    self.playerCenterXContraint.constant = centerX;
//    self.playerContraints = [NSArray arrayWithArray:cons];
//    
//    if (self.player.urlType == UrlTypeLive)
//    {
//        //生成新的ijksdlView默认旋转角度
//        [[NSNotificationCenter defaultCenter] postNotificationName:UCloudPlayerVideoChangeRotationNotification object:@(0)];
//    }
//    
//    self.isPrepared = NO;
//    
//    [self.view bringSubviewToFront:self.vc.view];
//    [self.vc setRightPanelHidden:YES];
//}
//
//- (void)buildMediaControl:(NSInteger)defaultNum data:(NSArray *)data
//{
//    UCloudMediaViewController *vc = [[UCloudMediaViewController alloc] initWithNibName:@"UCloudMediaViewController" bundle:nil];
//    self.vc = vc;
//    self.vc.center = self.view.center;
//    self.vc.defultQingXiDu = defaultNum;
//    if (self.player.defaultDecodeMethod == DecodeMthodHard)
//    {
//        self.vc.defultJieMaQi = 0;
//    }
//    else if (self.player.defaultDecodeMethod == DecodeMthodSoft)
//    {
//        self.vc.defultJieMaQi = 1;
//    }
//    self.vc.urlType = self.player.urlType;
//    
//    self.vc.defultHuaFu = 2;
//    self.player.player.scalingMode = MPMovieScalingModeAspectFill;
//    
//    self.vc.fileName = @"Test";
//    self.vc.movieInfos = data;
//    self.vc.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
//    self.vc.delegateAction = self;
//    self.vc.delegatePlayer = self.player.player;
//    
//    [self.view addSubview:self.vc.view];
//}
//
//
//#pragma mark - 屏幕旋转
//- (void)awakeSupportInterOrtation:(UIViewController *)showVC completion:(void(^)(void))block
//{
//    UIViewController *vc = [[UIViewController alloc] init];
//    void(^completion)() = ^() {
//        [showVC dismissViewControllerAnimated:NO completion:nil];
//        
//        if (block)
//        {
//            block();
//        }
//    };
//    
//    // This check is needed if you need to support iOS version older than 7.0
//    BOOL canUseTransitionCoordinator = [showVC respondsToSelector:@selector(transitionCoordinator)];
//    BOOL animated = YES;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0)
//    {
//        animated = NO;
//    }
//    else
//    {
//        animated = YES;
//    }
//    if (canUseTransitionCoordinator)
//    {
//        [showVC presentViewController:vc animated:animated completion:nil];
//        [showVC.transitionCoordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
//            completion();
//        }];
//    }
//    else
//    {
//        [showVC presentViewController:vc animated:NO completion:completion];
//    }
//}
////屏幕方向改变
//-(void)deviceOrientationChanged:(UIInterfaceOrientation)interfaceOrientation
//{
//    [self.vc setRightPanelHidden:YES];
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//    {
//        self.view.transform = CGAffineTransformIdentity;
//    }
//    
//    switch (interfaceOrientation) {
//        case UIInterfaceOrientationPortrait:
//        {
//            [self turnToPortraint:^{
//                
//            }];
//        }
//            break;
//        case UIInterfaceOrientationLandscapeLeft:
//        {
//            [self turnToLeft:^{
//                
//            }];
//        }
//            break;
//        case UIInterfaceOrientationLandscapeRight:
//        {
//            [self turnToRight:^{
//                
//            }];
//        }
//            break;
//        default:
//            break;
//    }
//    
//    BOOL shouldChangeFrame = NO;
//    if ((UIInterfaceOrientationIsLandscape(interfaceOrientation) && UIInterfaceOrientationIsPortrait(self.currentOrientation)) || (UIInterfaceOrientationIsPortrait(interfaceOrientation) && UIInterfaceOrientationIsLandscape(self.currentOrientation)))
//    {
//        shouldChangeFrame = YES;
//    }
//    
//    //调整缓冲提示的位置
//    if (shouldChangeFrame)
//    {
//        [self.vc.view.window changeFrame:interfaceOrientation];
//    }
//    
//    //重绘画面
//    [self.player refreshView];
//}
//
//- (void)rotateBegain:(UIInterfaceOrientation)noti
//{
//    [self deviceOrientationChanged:noti];
//}
//
//- (void)rotateEnd
//{
//    //重绘画面
//    [self.player refreshView];
//    [self.vc setRightPanelHidden:NO];
//    
//    [self.vc refreshProgressView];
//}
//
//-(void)turnToPortraint:(void(^)(void))block
//{
//    //    _playerBottomContraint.constant = -(UISCREEN_HEIGHT - UISCREEN_WIDTH);
//    
//    _playerHeightContraint.constant = -[self getContraintConstant];
//    _playerCenterXContraint.constant = -[self getContraintConstant]/2.f;
//    
//    
//    _vcBottomConstraint.constant = -[self getContraintConstant];
//    _danmuBottomContraint.constant = -[self getContraintConstant];
//    
////    self.playerHeightContraint.constant = -(UISCREEN_HEIGHT - UISCREEN_WIDTH);
////    self.playerCenterXContraint.constant = -(UISCREEN_HEIGHT - UISCREEN_WIDTH)/2.f;
////    
////    self.vcBottomConstraint.constant = -(UISCREEN_HEIGHT - UISCREEN_WIDTH);
////    self.danmuBottomContraint.constant = -(UISCREEN_HEIGHT - UISCREEN_WIDTH);
//    [self.player refreshView];
//    self.isFullscreen = NO;
//    
//    [self.vc hideMenu];
//    if (block)
//    {
//        block();
//    }
//}
//
//-(void)turnToLeft:(void(^)(void))block
//{
//    //    _playerBottomContraint.constant = -0.0;
//    self.playerCenterXContraint.constant = 0.0;
//    self.playerHeightContraint.constant = 0.0;
//    
//    
//    self.vcBottomConstraint.constant = -0.0;
//    self.danmuBottomContraint.constant = -0.0;
//    [self.player refreshView];
//    self.isFullscreen = YES;
//    if (block)
//    {
//        block();
//    }
//}
//
//-(void)turnToRight:(void(^)(void))block
//{
//    //    _playerBottomContraint.constant = -0.0;
//    self.playerCenterXContraint.constant = 0.0;
//    self.playerHeightContraint.constant = 0.0;
//    
//    self.vcBottomConstraint.constant = -0.0;
//    self.danmuBottomContraint.constant = -0.0;
//    [self.player refreshView];
//    self.isFullscreen = YES;
//    if (block)
//    {
//        block();
//    }
//}
//
//#pragma mark - save pic
//- (void)saveImageToPhotos:(UIImage*)savedImage
//{
//    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//}
//- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
//{
//    NSString *msg = nil ;
//    if(error != NULL){
//        msg = @"保存图片失败" ;
//    }else{
//        msg = @"保存图片成功" ;
//    }
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
//                                                    message:msg
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    alert.tag = AlertViewSaveSucess;
//    [alert show];
//}
//static bool showing = NO;
//#pragma mark - loading view
//- (void)showLoadingView
//{
//    if (!showing)
//    {
//        showing = YES;
//        
//        CGAffineTransform trans = self.view.transform;
//        
//        [self.vc.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:NO transForm:trans];
//    }
//}
//
//- (void)hideLoadingView
//{
//    showing = NO;
//    CGAffineTransform trans = self.view.transform;
//    [self.vc.view.window showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES transForm:trans];
//}
//
//#pragma mark - notification
//- (void)addNotification
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:UCloudPlaybackIsPreparedToPlayDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:UCloudPlayerLoadStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:UCloudMoviePlayerSeekCompleted object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:UCloudPlayerPlaybackStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:UCloudPlayerPlaybackDidFinishNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:UCloudMoviePlayerBufferingUpdate object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateEnd) name:UCloudViewControllerDidRotate object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateBegain:) name:UCloudViewControllerWillRotate object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:UCloudPlayerVideoChangeRotationNotification object:nil];
//}
//
//- (void)removeNotification
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudPlaybackIsPreparedToPlayDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudPlayerLoadStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudMoviePlayerSeekCompleted object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudPlayerPlaybackStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudPlayerPlaybackDidFinishNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudMoviePlayerBufferingUpdate object:nil];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudViewControllerDidRotate object:nil];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudViewControllerWillRotate object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UCloudPlayerVideoChangeRotationNotification object:nil];
//}
//
//- (void)noti:(NSNotification *)noti
//{
//    NSLog(@"%@", noti.name);
//    if ([noti.name isEqualToString:UCloudPlaybackIsPreparedToPlayDidChangeNotification])
//    {
//        [self.vc refreshMediaControl];
//        
//        if (self.current != 0)
//        {
//            [self.player.player setCurrentPlaybackTime:self.current];
//            self.current = 0;
//        }
//    }
//    else if ([noti.name isEqualToString:UCloudPlayerLoadStateDidChangeNotification])
//    {
//        if ([self.player.player loadState] == MPMovieLoadStateStalled)
//        {
//            //网速不好，开始缓冲
//            [self showLoadingView];
//        }
//        else if ([self.player.player loadState] == (MPMovieLoadStatePlayable|MPMovieLoadStatePlaythroughOK))
//        {
//            //缓冲完毕
//            [self hideLoadingView];
//        }
//    }
//    else if ([noti.name isEqualToString:UCloudMoviePlayerSeekCompleted])
//    {
//        
//    }
//    else if ([noti.name isEqualToString:UCloudPlayerPlaybackStateDidChangeNotification])
//    {
//        NSLog(@"backState:%ld", (long)[self.player.player playbackState]);
//        if (!self.isPrepared)
//        {
//            self.isPrepared = YES;
//            [self.player.player play];
//            
//            NSString *homeDirectory = NSHomeDirectory();
//            NSLog(@"homeDirectorypath:%@", homeDirectory);
//            
//            if (![self.player.player isPlaying])
//            {
//                [self.vc refreshCenterState];
//                
//            }
//        }
//    }
//    else if ([noti.name isEqualToString:UCloudPlayerPlaybackDidFinishNotification])
//    {
//        MPMovieFinishReason reson = [[noti.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
//        if (reson == MPMovieFinishReasonPlaybackEnded)
//        {
//            [self.vc stop];
//        }
//        else if (reson == MPMovieFinishReasonPlaybackError)
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"视频播放错误" delegate:self cancelButtonTitle:@"知道了"   otherButtonTitles: nil, nil];
//            alert.tag = AlertViewPlayerError;
//            [alert show];
//        }
//    }
//    else if ([noti.name isEqualToString:UCloudPlayerVideoChangeRotationNotification]&& self.supportAngleChange)
//    {
//        NSInteger rotation = [noti.object integerValue];
//        self.player.player.view.transform = CGAffineTransformIdentity;
//        float height = self.playerHeightContraint.constant;
//        
//        switch (rotation)
//        {
//            case 0:
//            {
////                [NSLayoutConstraint deactivateConstraints:self.p];
//                
//                [self.view removeConstraints:self.l];
//                
////                [NSLayoutConstraint activateConstraints:self.l];
//                
//                [self.view addConstraints:self.p];
//                
//                self.playerHeightContraint.constant=_portraitViewHeight;
//                self.player.player.view.transform = CGAffineTransformIdentity;
//            }
//                break;
//            case 90:
//            {
////                [NSLayoutConstraint deactivateConstraints:self.l];
//                
//                [self.view removeConstraints:self.p];
//                
////                [NSLayoutConstraint activateConstraints:self.p];
//                
//                [self.view addConstraints:self.l];
//                
//                self.playerHeightContraint = [self.l lastObject];
//                self.player.player.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
//            }
//                break;
//            case 180:
//            {
////                [NSLayoutConstraint deactivateConstraints:self.p];
//                
//                
//                [self.view removeConstraints:self.l];
//                
////                [NSLayoutConstraint activateConstraints:self.l];
//                
//                
//                [self.view addConstraints:self.p];
//                
//                
//                self.playerHeightContraint = [self.p firstObject];
//                self.player.player.view.transform = CGAffineTransformMakeRotation(-M_PI);
//            }
//                break;
//            case 270:
//            {
////                [NSLayoutConstraint deactivateConstraints:self.l];
//                
//                
//                [self.view removeConstraints:self.p];
//                
////                [NSLayoutConstraint activateConstraints:self.p];
//                
//                [self.view addConstraints:self.l];
//                
//                self.playerHeightContraint = [self.l lastObject];
//                self.player.player.view.transform = CGAffineTransformMakeRotation(-(M_PI+M_PI_2));
//            }
//                break;
//            default:
//                break;
//        }
//        self.playerHeightContraint.constant = height;
//        [self.player.player.view updateConstraintsIfNeeded];
//    }
//}
//
//#pragma mark - mediaControl delegate
//- (void)onClickMediaControl:(id)sender
//{
//    
//}
//
//- (void)onClickBack:(UIButton *)sender
//{
//    [self.player.player.view removeFromSuperview];
//    [self.vc.view removeFromSuperview];
//    [self.player.player shutdown];
//    self.player = nil;
//    
//    {
//        self.supportInterOrtation = UIInterfaceOrientationMaskPortrait;
//        [self awakeSupportInterOrtation:self.viewContorller completion:^{
//            self.supportInterOrtation = UIInterfaceOrientationMaskAllButUpsideDown;
//        }];
//    }
//    //获取缓存路径
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    for (NSString* cachdir in paths) {
//        NSLog(@"cachdir.name%@",cachdir);
//    }
//    NSString* tempath = NSTemporaryDirectory();
//    NSLog(@"tempath%@",tempath);
////    [NSFileManager defaultManager]
//    
//    //获得全部文件数组
//    NSString* dirPath = [paths objectAtIndex:0];
//    NSArray *fileAry =  [PlayerManager getAllFileNames:dirPath];
//    //遍历数组
//    for (NSString *fileName in fileAry) {
//        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
////        flag = [JRCleanCaches clearCachesWithFilePath:filePath];
//        NSLog(@"fileName%@,---------filePath%@",fileName,filePath);
//    }
//    
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:UCloudMoviePlayerClickBack object:self];
//}
//
//#pragma mark - 得到指定目录下的所有文件
//+ (NSArray *)getAllFileNames:(NSString *)dirPath{
//    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:dirPath error:nil];
//    return files;
//}
//
//- (void)onClickPlay:(id)sender
//{
//    [self.player.player play];
//}
//
//- (void)onClickPause:(id)sender
//{
//    [self.player.player pause];
//}
//
//- (void)durationSliderTouchBegan:(id)delta
//{
//    //        [self.player pause];
//}
//
//- (void)durationSliderTouchEnded:(id)delta
//{
//    CGFloat del = self.player.player.duration * [delta floatValue];
//    del = self.player.player.currentPlaybackTime + del;
//    [self.player.player setCurrentPlaybackTime:floor(del)];
//    [self.player.player prepareToPlay];
//}
//
//- (void)durationSliderValueChanged:(id)delta
//{
// 
//}
//
//- (void)clickBright:(id)sender
//{
//    
//}
//
//- (void)clickVolume:(id)sender
//{
//    
//}
//
//- (void)clickShot:(id)sender
//{
//    self.current = [self.player.player currentPlaybackTime];
//    UIImage *image = [self.player.player thumbnailImageAtCurrentTime];
//    [self saveImageToPhotos:image];
//}
//
//- (void)selectedDecodeMthod:(DecodeMthod)decodeMthod
//{
//    self.current = [self.player.player currentPlaybackTime];
//    [self.player selectDecodeMthod:decodeMthod];
//    [self reConfigurePlayer:0];
//    [self.player.player setCurrentPlaybackTime:self.current];
//}
//
//- (void)selectedDefinition:(Definition)definition
//{
//    self.current = [self.player.player currentPlaybackTime];
//    [self.player selectDefinition:definition];
//    [self reConfigurePlayer:0];
//    [self.player.player setCurrentPlaybackTime:self.current];
//}
//
//- (void)selectedScalingMode:(MPMovieScalingMode)scalingMode
//{
//    self.player.player.scalingMode = scalingMode;
//    [self reConfigurePlayer:0];
//}
//
//- (void)clickFull:(UCoudWebBlock)block
//{
//    [self.player.player pause];
//    
//    if(!self.isFullscreen)
//    {
//        UIDeviceOrientation deviceOr = [UIDevice currentDevice].orientation;
//        if (deviceOr == UIInterfaceOrientationLandscapeRight)
//        {
//            self.supportInterOrtation = UIInterfaceOrientationMaskLandscapeRight;
//            [self awakeSupportInterOrtation:self.viewContorller completion:^() {
//                
//                [self turnToRight:^{
//                    self.supportInterOrtation = UIInterfaceOrientationMaskAllButUpsideDown;
//                    [self.player.player play];
//                    self.currentOrientation = UIInterfaceOrientationLandscapeRight;
//                    //重绘画面
//                    [self.player refreshView];
//                }];
//            }];
//        }
//        else
//        {
//            self.supportInterOrtation = UIInterfaceOrientationMaskLandscapeLeft;
//            [self awakeSupportInterOrtation:self.viewContorller completion:^() {
//                
//                [self turnToLeft:^{
//                    self.supportInterOrtation = UIInterfaceOrientationMaskAllButUpsideDown;
//                    [self.player.player play];
//                    self.currentOrientation = UIInterfaceOrientationLandscapeLeft;
//                    //重绘画面
//                    [self.player refreshView];
//                }];
//            }];
//        }
//    }
//    else
//    {
//        self.supportInterOrtation = UIInterfaceOrientationMaskPortrait;
//        [self awakeSupportInterOrtation:self.viewContorller completion:^() {
//            
//            [self turnToPortraint:^{
//                self.supportInterOrtation = UIInterfaceOrientationMaskAllButUpsideDown;
//                [self.player.player play];
//                
//                //重绘画面
//                [self.player refreshView];
//            }];
//            
//        }];
//    }
//}
//
//- (void)clickDanmu:(BOOL)show
//{
//    
//}
//
//- (void)selectedMenu:(NSInteger)menu choi:(NSInteger)choi
//{
//    NSLog(@"menu:%ld__choi:%ld", (long)menu, (long)choi);
//}
//
//- (BOOL)screenState
//{
//    return self.isFullscreen;
//}
//
//-(float)getContraintConstant
//{
//    float delta = UISCREEN_HEIGHT - self.portraitViewHeight;
//    
//    if (delta < 0)
//    {
//        delta = 0;
//    }
//    else if (delta >= UISCREEN_HEIGHT)
//    {
//        delta = UISCREEN_HEIGHT - UISCREEN_WIDTH;
//    }
//    return delta;
//}
//
//-(NSUInteger)supportInterOrtation
//{
//    if (self.supportAutomaticRotation)
//    {
//        return _supportInterOrtation;
//    }
//    else
//    {
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}
//
//- (void)setSupportAutomaticRotation:(BOOL)supportAutomaticRotation
//{
//    _supportAutomaticRotation = supportAutomaticRotation;
//    if (_supportAutomaticRotation)
//    {
//        [self.vc setFullBtnState:NO];
//    }
//    else
//    {
//        [self.vc setFullBtnState:YES];
//    }
//}
//
//
//#pragma mark 验证码发送保存
//- (void)saveCodeTime
//{
//    [SaveCachesFile saveDataList:[NSDate date] fileName:DateSave];
//}
//
//- (NSDate *)loadCodeTime
//{
//    return [SaveCachesFile loadDataList:DateSave];
//}

@end
