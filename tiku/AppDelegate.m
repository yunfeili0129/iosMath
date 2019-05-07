//
//  AppDelegate.m
//  tiku
//
//  Created by zhixinB on 2019/5/5.
//  Copyright © 2019 zhixinB. All rights reserved.
//

#import "AppDelegate.h"
#import "Net_Url.h"
#import "Net_Helper.h"
#define USER_NAME @"13716517873"
#define USER_PASS @"11223344q"
#define StrFormObj(obj) [NSString stringWithFormat:@"%@", obj]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loginWithUserName:USER_NAME password:USER_PASS];
    return YES;
}
//模拟登录
-(void)loginWithUserName:(NSString *)username password:(NSString *)pass
{
    [Net_Helper post:NewLOGIN_URL param:@{@"mobile":username, @"password":pass} success:^(NSDictionary * _Nonnull resultDict) {
        [[NSUserDefaults standardUserDefaults] setObject:@{StrFormObj(resultDict[@"data"][@"tokenKey"]) : StrFormObj(resultDict[@"data"][@"tokenValue"])}
                            forKey:@"tokenKeyAndValue"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
