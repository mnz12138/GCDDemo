//
//  ViewController.m
//  GCDDemo
//
//  Created by caishihui on 2019/10/8.
//  Copyright © 2019 wqj. All rights reserved.
//

#import "ViewController.h"
#import "PermanentThreadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self gcdSyncSerialAction];
//    [self gcdAsyncSerialAction];
//    [self gcdSyncParallelAction];
    [self gcdAsyncParallelAction];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(testAction) withObject:nil afterDelay:0];
        [[NSRunLoop currentRunLoop] run];
    });
    [self performSelector:@selector(testAction) onThread:[PermanentThreadManager shareThread] withObject:nil waitUntilDone:NO];
}
- (void)testAction {
    NSLog(@"%s-%@",__func__,[NSThread currentThread]);
}
//同步串行，不创建线程
- (void)gcdSyncSerialAction {
    dispatch_queue_t queue = dispatch_queue_create("com.mnz", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1-%@",[NSThread currentThread]);
    dispatch_sync(queue, ^{
        NSLog(@"2-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-%@",[NSThread currentThread]);
    });
    NSLog(@"4-%@",[NSThread currentThread]);
}
//异步串行，创建一个线程
- (void)gcdAsyncSerialAction {
    dispatch_queue_t queue = dispatch_queue_create("com.mnz", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1-%@",[NSThread currentThread]);
    dispatch_async(queue, ^{
        NSLog(@"3-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4-%@",[NSThread currentThread]);
    });
    NSLog(@"2-%@",[NSThread currentThread]);
}
//同步并行，不创建线程
- (void)gcdSyncParallelAction {
    dispatch_queue_t queue = dispatch_queue_create("com.mnz", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1-%@",[NSThread currentThread]);
    dispatch_sync(queue, ^{
        NSLog(@"2-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-%@",[NSThread currentThread]);
    });
    NSLog(@"4-%@",[NSThread currentThread]);
}
//异步并行，具备创建多个线程能力
- (void)gcdAsyncParallelAction {
    dispatch_queue_t queue = dispatch_queue_create("com.mnz", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1-%@",[NSThread currentThread]);
    dispatch_async(queue, ^{
        NSLog(@"3-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4-%@",[NSThread currentThread]);
    });
    NSLog(@"2-%@",[NSThread currentThread]);
}

@end
