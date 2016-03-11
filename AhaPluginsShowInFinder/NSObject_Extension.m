//
//  NSObject_Extension.m
//  AhaPluginsShowInFinder
//
//  Created by haiwei on 3/11/16.
//  Copyright © 2016 vvlvv. All rights reserved.
//


#import "NSObject_Extension.h"
#import "AhaPluginsShowInFinder.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[AhaPluginsShowInFinder alloc] initWithBundle:plugin];
        });
    }
}
@end
