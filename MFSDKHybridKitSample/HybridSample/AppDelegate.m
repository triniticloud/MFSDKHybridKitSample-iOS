//
//  AppDelegate.m
//  KotakSample
//
//  Created by Admin on 2/20/18.
//  Copyright © 2018 Active.AI All rights reserved.
//

#import "AppDelegate.h"
#import <MFSDKMessagingKit/MFSDKMessagingManager.h>
#import <MFNotificationKit/MFSDKNotificationKitManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    //let MFSDKNotificationKitManager register push pass Yes otherwise NO
    [[MFSDKApplicationDelegate sharedAppDelegate] application:application didFinishLaunchingWithOptions:launchOptions withRegisterPush:YES];
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    } else {
        // Fallback on earlier versions
    }
    
    if (launchOptions)
    {
        //launchOptions is not nil, means APNS recieved
        NSLog(@"completion launchOptions %@",launchOptions);
        NSDictionary *userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        self.handleNotificationOnLaunch = YES;
        if(userInfo!=nil){
            self.userInfoDic=[[NSDictionary alloc]initWithDictionary:userInfo];
        }
        
    }
    
    return YES;
}
-(void)setPropertiesNil{
    self.handleNotificationOnLaunch=NO;
    self.userInfoDic = nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[MFSDKApplicationDelegate sharedAppDelegate] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


//Handling Apple Push Call Back
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[MFSDKApplicationDelegate sharedAppDelegate] application:app didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[MFSDKApplicationDelegate sharedAppDelegate] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0));
{
    [[MFSDKApplicationDelegate sharedAppDelegate] userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
API_AVAILABLE(ios(10.0)){
    
    [[MFSDKApplicationDelegate sharedAppDelegate] userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[MFSDKApplicationDelegate sharedAppDelegate]application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [[MFSDKApplicationDelegate sharedAppDelegate]application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

@end
