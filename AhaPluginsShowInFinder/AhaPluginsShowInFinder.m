//
//  AhaPluginsShowInFinder.m
//  AhaPluginsShowInFinder
//
//  Created by haiwei on 3/11/16.
//  Copyright © 2016 vvlvv. All rights reserved.
//

#import "AhaPluginsShowInFinder.h"

@interface AhaPluginsShowInFinder()

@property (nonatomic, strong, readwrite) NSBundle *bundle;


@end

@implementation AhaPluginsShowInFinder

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
     [self addPluginsMenu];
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 

- (void)addPluginsMenu
{
    NSMenu *mainMenu = [NSApp mainMenu];
    NSMenuItem *pluginsMenuItem = [mainMenu itemWithTitle:@"Plugins"];
    if (!pluginsMenuItem) {
        pluginsMenuItem = [[NSMenuItem alloc] init];
        pluginsMenuItem.title = @"Plugins";
        pluginsMenuItem.submenu = [[NSMenu alloc] initWithTitle:pluginsMenuItem.title];
        NSInteger windowIndex = [mainMenu indexOfItemWithTitle:@"Window"];
        [mainMenu insertItem:pluginsMenuItem atIndex:windowIndex];
    }
    
    [pluginsMenuItem.submenu addItem:[NSMenuItem separatorItem]];
    NSMenuItem *mainMenuItem = [[NSMenuItem alloc] init];
    mainMenuItem.title = @"Aha Plugins Show In Finder";
    mainMenuItem.target = self;
    mainMenuItem.action = @selector(doMenuAction);
    [pluginsMenuItem.submenu addItem:mainMenuItem];
    [pluginsMenuItem.submenu addItem:[NSMenuItem separatorItem]];
}

- (void)doMenuAction
{
    NSRange range = [self.bundle.bundlePath rangeOfString:@"Plug-ins"];
    NSString * filePath = [self.bundle.bundlePath substringToIndex:range.location + range.length];
    NSString * rootPath = [self.bundle.bundlePath substringToIndex:range.location];
    [[NSWorkspace sharedWorkspace] selectFile:filePath inFileViewerRootedAtPath:rootPath];
}


@end
