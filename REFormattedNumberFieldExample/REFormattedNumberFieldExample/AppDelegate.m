//
//  AppDelegate.m
//  REFormattedNumberFieldExample
//
//  Created by Roman Efimov on 2/21/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[RootViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
