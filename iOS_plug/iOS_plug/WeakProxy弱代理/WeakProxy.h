//
//  WeakProxy.h
//  iOS_plug
//
//  Created by wiley on 2020/5/29.
//  Copyright © 2020 wiley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakProxy : NSProxy

+ (instancetype)weakProxyForObject:(id)targetObject;

@end

NS_ASSUME_NONNULL_END
