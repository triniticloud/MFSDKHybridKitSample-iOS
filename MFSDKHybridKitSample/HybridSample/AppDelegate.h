//
//  AppDelegate.h
//  KotakSample
//
//  Created by Admin on 2/20/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *userInfoDic;
@property(nonatomic,assign)BOOL handleNotificationOnLaunch;
-(void)setPropertiesNil;


@end

