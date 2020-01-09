//
//  MFSDKApplicationDelegate.h
//  MFNotificationKit
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Mac. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN
@protocol MFNotificationKitDelegate <NSObject>
@optional
-(void)sendPushData:(NSDictionary*)userInfo;
-(BOOL)isMorfeusScreensOnTop;
-(void)handleOnScreenPushTapWithUserInfo:(NSDictionary*)userInfo;
-(void)appStartWithPushTapWithUserInfo:(NSDictionary*)userInfo;
@end
@interface MFSDKApplicationDelegate : NSObject
+ (MFSDKApplicationDelegate *)sharedAppDelegate;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions withRegisterPush:(BOOL)registerPush;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillResignActive:(UIApplication *)application;
@property(nonatomic,weak)id <MFNotificationKitDelegate> messagingDelegate;

//APNS
- (BOOL)isMorfeusNotificationWithUserInfo:(NSDictionary *)userInfo;
- (void)registerForApplePushNotifications;
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (BOOL)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0));
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0));
-(void)displayRMFMessageWithUserInfo:(NSDictionary*)userInfo;
@end

NS_ASSUME_NONNULL_END
