//
//  ViewController.m
//  TBPlayer
//
//  Created by qianjianeng on 16/1/31.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "ViewController.h"
#import "TBPlayer.h"
#import "XCHudHelper.h"
#import "avplayerVC.h"
#import "Httptool.h"


@interface ViewController ()



@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    


}


- (IBAction)button:(UIButton *)sender {
    
    avplayerVC *vc = [avplayerVC new];
    vc.type = 0;
    [self presentViewController:vc animated:NO completion:nil];
    
    
    
    
}

#pragma mark - 上传视频的接口
- (IBAction)updata:(id)sender {
    
//
////    [self upviedolistData];
//    avplayerVC * vc = [avplayerVC new];
//    vc.type = 1;
//    [self presentViewController:vc animated:NO completion:nil];
    
    
    
    
}


- (void)upviedoData
{
    //POST /finish/uvideoUploads/<Key>?UploadId=<upload_id> HTTP/1.1
    //
    //Host: upload.uvideo.ucloud.com.cn
    //
    //Bucket: <bucket_name>
    //
    //Authorization: <token>
    //
    //Content-Type: <mimetype>
    //
    //Content-Length: <length>
    
    NSString* strurl = @"/finish/uvideoUploads/<Key>?UploadId=<upload_id> HTTP/1.1";
    //    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:kLoginTokenIdentifier];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@"upload.uvideo.ucloud.com.cn" forKey:@"Host"];
    [params setObject:@"<bucket_name>" forKey:@"Bucket"];
    
    //u/getUserInfoByMobile//isSign
    [Httptool postWithURL:strurl Params:params Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
            if ([dic[@"data"][@"isSign"] integerValue] == 0) {
                
                //                AccountManageViewController* accountVC = [[AccountManageViewController alloc]initWithIdentifer:@"0"];
                //                [self.navigationController pushViewController:accountVC animated:YES];
                
            }else{
                //                AccountManageViewController* accountVC = [[AccountManageViewController alloc]initWithIdentifer:@"1"];
                //                [self.navigationController pushViewController:accountVC animated:YES];
            }
            
            
        }else{
            //            [SVProgressHUD showErrorWithStatus:[dic objectForKey:@"msg"]duration:2];
        }
    } Failure:^(NSError *error) {
        
    }];

}

- (void)upviedolistData
{
    //Action	true	String	对应的API名称，如CreateUHostInstance
    //PublicKey	true	String	用户公钥
    //Signature	true	String	根据公钥及API指令生成的用户签名，参见 签名算法
    //ProjectId	false	String	项目ID，为空时及为默认项目
    
    
    NSString* strurl = @"?Action=GetVideoFileBySpace&PublicKey=ucloudsomeone@example.com1296235120854146120&Signature=46f09bb9fab4f12dfc160dae12273d5332b5debe";
    //u/getUserInfoByMobile//isSign
    [Httptool postWithURL:strurl Params:nil Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        
//        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
//            if ([dic[@"data"][@"isSign"] integerValue] == 0) {
//                
//                //                AccountManageViewController* accountVC = [[AccountManageViewController alloc]initWithIdentifer:@"0"];
//                //                [self.navigationController pushViewController:accountVC animated:YES];
//                
//            }else{
//                //                AccountManageViewController* accountVC = [[AccountManageViewController alloc]initWithIdentifer:@"1"];
//                //                [self.navigationController pushViewController:accountVC animated:YES];
//            }
//            
//            
//        }else{
//            //            [SVProgressHUD showErrorWithStatus:[dic objectForKey:@"msg"]duration:2];
//        }
    } Failure:^(NSError *error) {
        
    }];
    

}









@end
