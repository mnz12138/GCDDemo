//
//  PermanentThreadManager.m
//  GCDDemo
//
//  Created by caishihui on 2019/10/8.
//  Copyright © 2019 wqj. All rights reserved.
//

#import "PermanentThreadManager.h"

@implementation PermanentThreadManager

+ (NSThread *)shareThread {
    static NSThread *shareThread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
        [shareThread setName:@"share_thread"];
        [shareThread start];
    });
    return shareThread;
}
+ (void)threadTest {
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}

@end
