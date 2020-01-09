//
//  MFNotificationKitManager.h
//  MFNotificationKit
//
//  Created by admin on 20/02/19.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFNotificationData.h"
#import "MFSDKApplicationDelegate.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MFNotificationKitManagerDelegate <NSObject>
@optional

-(void)sendPushDataToMessagingKit:(NSDictionary*)userInfo;
-(BOOL)isMorfeusScreenOnTopInMessagingKit;
-(void)askTohandleOnScreenPushTapWithUserInfo:(MFNotificationData*)userInfo;
-(void)askTohandlePushTapWithUserInfo:(NSDictionary*)userInfo;
@end
@interface MFSDKNotificationKitManager : NSObject
+ (instancetype)sharedInstance;
@property(nonatomic,weak)id <MFNotificationKitManagerDelegate> notificationDelegate;

@end

NS_ASSUME_NONNULL_END
