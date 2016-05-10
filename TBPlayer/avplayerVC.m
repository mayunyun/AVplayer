//
//  avplayerVC.m
//  TBPlayer
//
//  Created by qianjianeng on 16/2/27.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "avplayerVC.h"
#import "TBPlayer.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface avplayerVC ()

@property (nonatomic, strong) TBPlayer *player;
@property (nonatomic, strong) UIView *showView;
@end

@implementation avplayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showView = [[UIView alloc] init];
    self.showView.backgroundColor = [UIColor redColor];
    self.showView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:self.showView];
    
    
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *movePath =  [document stringByAppendingPathComponent:@"保存数据.mp4"];
    NSURL *localURL = [NSURL fileURLWithPath:movePath];
    
    
    
    NSString *path = NSHomeDirectory();//主目录
    NSString *path1 = [path stringByAppendingPathComponent:@"Library/Caches/test.mp4"];
    NSLog(@"11111  %@",path1);
    NSURL* localpath1 = [NSURL fileURLWithPath:path1];
    
    
    NSURL *url3 = [NSURL URLWithString:@"http://lianxiang.ufile.ucloud.com.cn/lx_dhxy.mp4"];//@"http://mediademo.ufile.ucloud.com.cn/ucloud_promo_140s.mp4"];//
    
    
//    NSURL *url2 = [NSURL URLWithString:@"http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0"];
    //url2 = [NSURL URLWithString:@"http://v4ttyey-10001453.video.myqcloud.com/Microblog/288-4-1452304375video1466172731.mp4"];
    
    
//    [[TBPlayer sharedInstance] playWithUrl:url3 showView:self.showView];
    switch (_type) {
        case 0:
        {
            [[TBPlayer sharedInstance] playWithUrl:url3 showView:self.showView];
        }
            break;
        case 1:
        {
             [[TBPlayer sharedInstance] playWithUrl:localpath1 showView:self.showView];
        }
            break;
            
        default:
            break;
    }
    
    
    

}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        NSLog(@"%ld",(long)toInterfaceOrientation);
        //纵
        
        
    }
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        //横
        NSLog(@"%ld",(long)toInterfaceOrientation);
    }
}




@end
