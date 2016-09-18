//
//  VCManager.m
//  ManyViewSlider
//
//  Created by 刘松洪 on 16/9/8.
//  Copyright © 2016年 刘松洪. All rights reserved.
//

#import "VCManager.h"
#import "PageViewController.h"
@implementation VCManager

+ (instancetype)share {

   static VCManager *instance = nil;
   static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VCManager alloc]init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     PageViewController *vc = [[PageViewController alloc]init];
     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
     NSLog(@"%@",application.delegate.window);
     application.delegate.window = [[UIWindow alloc]init];
     application.delegate.window.frame = [UIScreen mainScreen].bounds;
    [application.delegate.window setBackgroundColor: [UIColor whiteColor]];
    [application.delegate.window makeKeyWindow];
     application.delegate.window.rootViewController = nav;
}

@end
