//
//  TBVideoRequestTask.m
//  avplayerSavebufferData
//
//  Created by qianjianeng on 15/9/18.
//  Copyright (c) 2015年 qianjianeng. All rights reserved.
//

#import "TBVideoRequestTask.h"

@interface TBVideoRequestTask () <NSURLConnectionDataDelegate, AVAssetResourceLoaderDelegate>

@property (nonatomic, strong) NSURL           *url;
@property (nonatomic        ) NSUInteger      offset;

@property (nonatomic        ) NSUInteger      videoLength;
@property (nonatomic, strong) NSString        *mimeType;

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableArray  *taskArr;

@property (nonatomic, assign) NSUInteger      downLoadingOffset;
@property (nonatomic, assign) BOOL            once;

@property (nonatomic, strong) NSFileHandle    *fileHandle;
@property (nonatomic, strong) NSString        *tempPath;

@end

@implementation TBVideoRequestTask

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskArr = [NSMutableArray array];
        
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        _tempPath =  [document stringByAppendingPathComponent:@"temp.mp4"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:_tempPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:_tempPath error:nil];
            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
            
        } else {
            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
        }
        
    }
    return self;
}

#pragma mark - 得到指定目录下的所有文件
+ (NSArray *)getAllFileNames:(NSString *)dirPath{
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:dirPath error:nil];
    return files;
}

- (void)setUrl:(NSURL *)url offset:(NSUInteger)offset
{
    _url = url;
    _offset = offset;
    
    //如果建立第二次请求，先移除原来文件，再创建新的
    if (self.taskArr.count >= 1) {
        [[NSFileManager defaultManager] removeItemAtPath:_tempPath error:nil];
        [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
    }
    
    _downLoadingOffset = 0;
    
    NSURLComponents *actualURLComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    actualURLComponents.scheme = @"http";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[actualURLComponents URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
    
    if (offset > 0 && self.videoLength > 0) {
        [request addValue:[NSString stringWithFormat:@"bytes=%ld-%ld",(unsigned long)offset, (unsigned long)self.videoLength - 1] forHTTPHeaderField:@"Range"];
    }

    [self.connection cancel];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [self.connection setDelegateQueue:[NSOperationQueue mainQueue]];
    [self.connection start];
       
}



- (void)cancel
{
    [self.connection cancel];
    
}


#pragma mark -  NSURLConnection Delegate Methods


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _isFinishLoad = NO;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;

    NSDictionary *dic = (NSDictionary *)[httpResponse allHeaderFields] ;
    
    NSString *content = [dic valueForKey:@"Content-Range"];
    NSArray *array = [content componentsSeparatedByString:@"/"];
    NSString *length = array.lastObject;
    
    NSUInteger videoLength;
    
    if ([length integerValue] == 0) {
        videoLength = (NSUInteger)httpResponse.expectedContentLength;
    } else {
        videoLength = [length integerValue];
    }
    
    self.videoLength = videoLength;
    self.mimeType = @"video/mp4";
    

    if ([self.delegate respondsToSelector:@selector(task:didReceiveVideoLength:mimeType:)]) {
        [self.delegate task:self didReceiveVideoLength:self.videoLength mimeType:self.mimeType];
    }
    
    [self.taskArr addObject:connection];
    
    
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:_tempPath];
    
   
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [self.fileHandle seekToEndOfFile];
    
    [self.fileHandle writeData:data];

    _downLoadingOffset += data.length;
    
    
    if ([self.delegate respondsToSelector:@selector(didReceiveVideoDataWithTask:)]) {
        [self.delegate didReceiveVideoDataWithTask:self];
    }
    
    
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.taskArr.count < 2) {
        _isFinishLoad = YES;
        
        
        NSString *path = NSHomeDirectory();//主目录
        NSString *path1 = [path stringByAppendingPathComponent:@"Library/Caches/text.mp4"];
        NSLog(@"11111  %@",path1);
        NSError* error1 = nil;
        BOOL isSuccess1 = [[NSFileManager defaultManager] copyItemAtPath:_tempPath toPath:path1 error:&error1];
        if (isSuccess1) {
            NSLog(@"rename success");
        }else{
            NSLog(@"rename fail,%@",error1.localizedDescription);
            
        }
        NSLog(@"----%@", path1);
        
        
//        //获取缓存路径
//        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
////        for (NSString* cachdir in paths) {
////NSLog(@"cachdir.name%@",cachdir);
////        }
//        //将数组内容写入该文件
//        
//        //获得全部文件数组
//        NSString* dirPath = [paths objectAtIndex:0];
//        NSString *movPath = [dirPath stringByAppendingFormat:@"/music"];
//        NSLog(@"movPath%@",movPath);
//        NSString *filePath = [dirPath stringByAppendingPathComponent:@"test.mp4"];
//        //在IOS中通过 NSFileManager单例类来操作沙盒里面的文件或文件夹
//        
//        BOOL isDirectory = NO;
//        //&isDirectory为真,路径存在，可能为文件也可能为文件夹
//        if (![[NSFileManager defaultManager] fileExistsAtPath:movPath isDirectory:&isDirectory ]&& !isDirectory) {
//            
//            NSLog(@"不存在该路径");
//            //如果文件夹不存在，创建文件夹
//            NSError *err = nil;
//            BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:movPath withIntermediateDirectories:YES attributes:nil error:&err];
//            if (isSuccess) {
//                NSLog(@"%@",movPath);
//            }
//        }
//        //判断musicPath是文件还是文件夹,,[[NSFileManager defaultManager] fileExistsAtPath:musicPath isDirectory:&isDirectory]为真
//        if ([[NSFileManager defaultManager] fileExistsAtPath:movPath isDirectory:&isDirectory]&& isDirectory) {
//            NSLog(@"music是一个文件夹");
//            
//            NSString *strPathOld = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
//            NSData *data = [NSData dataWithContentsOfFile:strPathOld];
//            
//            BOOL result = [data writeToFile:filePath atomically:YES];
//            
//            
//            
//        }else if ([[NSFileManager defaultManager] fileExistsAtPath:movPath isDirectory:&isDirectory]){
//            
//            NSLog(@"wenjian");
//            NSError *error = nil;
//            BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:_tempPath toPath:movPath error:&error];
//            if (isSuccess) {
//                NSLog(@"rename success");
//            }else{
//                NSLog(@"rename fail,%@",error.localizedDescription);
//                
//            }
//            NSLog(@"----%@", movPath);
//            
//            
//        }else{
//            
//            NSLog(@"文件与文件夹都不存在");
//        }

        
        
        
//        NSArray *fileAry =  [TBVideoRequestTask getAllFileNames:dirPath];
//        //遍历数组
//        for (NSString *fileName in fileAry) {
//            NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
//            //        flag = [JRCleanCaches clearCachesWithFilePath:filePath];
//            NSLog(@"fileName%@,---------filePath%@",fileName,filePath);
//        }

        
//        //这里自己写需要保存数据的路径
//        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//        NSString *movePath =  [document stringByAppendingPathComponent:@"保存数据.mp4"];
//        if ([[NSFileManager defaultManager] fileExistsAtPath:_tempPath]) {
//            [[NSFileManager defaultManager] removeItemAtPath:_tempPath error:nil];
//            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
//            
//        } else {
//            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
//        }
//
//        NSError *error = nil;
//        BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:_tempPath toPath:movePath error:&error];
//        if (isSuccess) {
//            NSLog(@"rename success");
//        }else{
//            NSLog(@"rename fail,%@",error.localizedDescription);
//            
//        }
//        NSLog(@"----%@", movePath);
        
    }
    
    if ([self.delegate respondsToSelector:@selector(didFinishLoadingWithTask:)]) {
        [self.delegate didFinishLoadingWithTask:self];
    }
    
}

//网络中断：-1005
//无网络连接：-1009
//请求超时：-1001
//服务器内部错误：-1004
//找不到服务器：-1003
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (error.code == -1001 && !_once) {      //网络超时，重连一次
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self continueLoading];
        });
    }
    if ([self.delegate respondsToSelector:@selector(didFailLoadingWithTask:WithError:)]) {
        [self.delegate didFailLoadingWithTask:self WithError:error.code];
    }
    if (error.code == -1009) {
        NSLog(@"无网络连接");
    }
}


- (void)continueLoading
{
    _once = YES;
    NSURLComponents *actualURLComponents = [[NSURLComponents alloc] initWithURL:_url resolvingAgainstBaseURL:NO];
    actualURLComponents.scheme = @"http";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[actualURLComponents URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
    
    [request addValue:[NSString stringWithFormat:@"bytes=%ld-%ld",(unsigned long)_downLoadingOffset, (unsigned long)self.videoLength - 1] forHTTPHeaderField:@"Range"];
    
    
    [self.connection cancel];
     self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [self.connection setDelegateQueue:[NSOperationQueue mainQueue]];
    [self.connection start];
}

- (void)clearData
{
    [self.connection cancel];
    //移除文件
    [[NSFileManager defaultManager] removeItemAtPath:_tempPath error:nil];
    
    
    
}
@end
