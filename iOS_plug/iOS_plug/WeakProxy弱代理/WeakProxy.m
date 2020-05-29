//
//  WeakProxy.m
//  iOS_plug
//
//  Created by wiley on 2020/5/29.
//  Copyright © 2020 wiley. All rights reserved.
//

#import "WeakProxy.h"

@interface WeakProxy()

@property (nonatomic, weak) id target;

@end

@implementation WeakProxy

+ (instancetype)weakProxyForObject:(id)targetObject {
    WeakProxy *weakProxy = [WeakProxy alloc];
    weakProxy.target = targetObject;
    return weakProxy;
}

#pragma mark Forwarding Messages

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
