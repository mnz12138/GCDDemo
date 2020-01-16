//
//  PermanentThreadManager.h
//  GCDDemo
//
//  Created by caishihui on 2019/10/8.
//  Copyright © 2019 wqj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PermanentThreadManager : NSObject

+ (NSThread *)shareThread;

@end

NS_ASSUME_NONNULL_END
