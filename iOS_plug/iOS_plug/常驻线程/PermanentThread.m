//
//  PermanentThread.m
//  iOS_plug
//
//  Created by wiley on 2020/6/24.
//  Copyright © 2020 wiley. All rights reserved.
//
// AFNetworking 2.0 基于 NSURLConnection 构建

#import "PermanentThread.h"

@interface PermanentThread()

@property (nonatomic, strong) NSLock *lock;

@end

@implementation PermanentThread

+ (void)permanentThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"iOS_plug"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}
 
+ (NSThread *)permanentThread {
    static NSThread *permanentThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        permanentThread = [[NSThread alloc] initWithTarget:self selector:@selector(permanentThreadEntryPoint:) object:nil];
        [permanentThread start];
    });
    return permanentThread;
}

- (void)start {
    [self.lock lock];
    
    // [NSObject performSelector:onThread:..]
    
    [self.lock unlock];
}
@end
