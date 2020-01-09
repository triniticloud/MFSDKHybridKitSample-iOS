//
//  MFSDKMessagingManager.h
//  MFSDKMessagingKit
//
//  Created on 11/28/16.
//  Copyright © 2016 ActiveAI. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MFSDKProperties.h"
#import "MFSDKSessionProperties.h"

@interface MFSDKMessagingManager : NSObject
+ (instancetype)sharedInstance;
+ (void)resetSharedInstance;
- (NSDictionary*)preferences;

-(void)initWithProperties:(MFSDKProperties *)sdkProperties;
-(id)showScreenWithBotID:(NSString*)botId fromViewController:(id)viewController withSessionProperties:(MFSDKSessionProperties*)properties;
-(void)closeScreenWithBotID:(NSString*)botId;
-(void)closeScreenWithBotID:(NSString*)botId withAnimation:(BOOL)animation;
-(void)logout;
-(void)setSSLResult:(BOOL)isValid withRequestCode:(NSString*)requestCode;
-(void)registerMFNotificationKitManager:(id)mfNotificationKitManagerObj;
-(id)showScreenWithWorkSpaceId:(NSString*)workSpaceId fromViewController:(id)viewController withSessionProperties:(MFSDKSessionProperties*)properties;

@end
