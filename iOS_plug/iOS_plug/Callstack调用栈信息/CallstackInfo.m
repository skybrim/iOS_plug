//
//  CallstackInfo.m
//  iOS_plug
//
//  Created by wiley on 2021/1/26.
//  Copyright © 2021 wiley. All rights reserved.
//

#import "CallstackInfo.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

@implementation CallstackInfo

+ (void)showAll {
    void *callStack[128];
    int frames = backtrace(callStack, 128);
    char **strs = backtrace_symbols(callStack, frames);
    
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; ++i) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    NSLog(@"=====callstack=====\n%@", backtrace);
}

@end
