//
//  MFSDKProperties.h
//  MFSDKCoreKit
//
//  Created on 1/30/17.
//  Copyright © 2017 ActiveAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MFSearchResponseModel.h"
//this is the version for the released pod
#define SDK_POD_VERSION @"2.4.00"
typedef NS_ENUM(NSUInteger, BotPresentationStyle) {
    PresentationFullScreen = 701,
    PresentationAutomatic = 702,
};

@protocol MFSDKMessagingDelegate <NSObject>
@optional
//main app will write the necessary implementation to keep itself alive
-(void)onSearchResponse:(MFSearchResponseModel *)model;

//SSL Pinning
-(void)onSSLCheckWithUrl:(NSString*)url withRequestCode:(NSString*)requestCode;

//Logout listener
-(void)onLogout:(NSInteger)logoutType;

//close tapped
-(void)onChatClose;
//hamburger icon tapped
-(void)onHamburgermenubtnclick;

//home icon tapped
-(void)onHomemenubtnclick;
@end

@interface MFSDKProperties : NSObject

@property(nonatomic,strong)NSString *domain;
@property(nonatomic,strong)NSString *appVersion;
@property(nonatomic,strong)NSString *workSpaceId;
@property(nonatomic,assign)BOOL enableSSL;
@property(nonatomic,assign)BOOL displayFullScreen;
@property(nonatomic,strong)NSMutableDictionary *navigationBarDetails;
//@property(nonatomic,assign)NSInteger inActivityTimeout;
@property(nonatomic,weak)id <MFSDKMessagingDelegate> messagingDelegate;
@property(nonatomic,assign)BOOL hideContentInBackground;
@property(nonatomic,assign)BOOL showNativeNavigationBar;
@property(nonatomic,assign)BOOL enableScheduledBackgroundRefresh;
@property(nonatomic,assign)BOOL enableAnalytics;
@property(nonatomic,strong)NSString *analyticsProvider;
@property(nonatomic,strong)NSString *analyticsId;
@property(nonatomic,strong)NSArray *analyticsCrossDomains;
@property (nonatomic,strong) UIColor* sdkStatusBarColor;
@property (nonatomic) BotPresentationStyle botModalPresentationStyle;
-(instancetype)initWithDomain:domainUrl;
-(void)addBot:(NSString*)botId botName:(NSString*)botName;
-(void)enableSSL:(BOOL)enableSSL sslPins:(NSArray*)hashedPins;
-(void)setNavigationBackGroundWithHexColor:(NSString*)hexColorCode;
-(void)setNavigationBackGroundWithImage:(NSString*)imageName;
-(void)setLeftNavigationBarButtonWithImage:(NSString*)imageName;
-(void)setRightNavigationBarButtonWithImage:(NSString*)imageName;
-(void)setNavigationBarTitleWithText:(NSString*)titleText;
-(void)setNavigationBarTitleWithImage:(NSString*)imageName;
-(void)showNativeNavigationBar:(BOOL)show;
-(int)getTheme;
-(void)enableCheck:(BOOL)boolValue;
@end
