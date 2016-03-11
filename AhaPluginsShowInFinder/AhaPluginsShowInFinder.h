//
//  AhaPluginsShowInFinder.h
//  AhaPluginsShowInFinder
//
//  Created by haiwei on 3/11/16.
//  Copyright © 2016 vvlvv. All rights reserved.
//

#import <AppKit/AppKit.h>

@class AhaPluginsShowInFinder;

static AhaPluginsShowInFinder *sharedPlugin;

@interface AhaPluginsShowInFinder : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end