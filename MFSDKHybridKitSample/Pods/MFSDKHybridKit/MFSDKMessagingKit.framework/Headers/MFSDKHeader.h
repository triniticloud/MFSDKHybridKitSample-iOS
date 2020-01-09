//
//  MFSDKHeader.h
//  MFSDKMessagingKit
//
//  Created by Mac on 1/25/19.
//  Copyright © 2019 Active AI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ButtonAction) {
    BACK_BUTTON = 101,
    NAVIGATION_BUTTON = 102,
    HOME_BUTTON = 103,
    LOGOUT_BUTTON = 104
};
typedef NS_ENUM(NSUInteger, Alignment) {
    LEFT_ALIGN = 201,
    CENTER_ALIGN = 202,
};

@interface MFSDKHeader : NSObject
//Type of Navigation Bar
@property(nonatomic,assign)BOOL isCustomNavigationBar;
//TITLE RELATED PROPERTIES
@property(nonatomic,strong) NSString *titleText;
@property(nonatomic,strong) NSString *titleImage;
@property (nonatomic,strong) NSString* titleColor;
@property (nonatomic) Alignment titleAlignment;
@property (nonatomic) float titleFontSize;
@property (nonatomic,strong) NSString* titleFontName;
//SUBTITLE RELATED PROPERTIES
@property (nonatomic,strong) NSString* subTitleText;
@property (nonatomic,strong) NSString* subTitleColor;
@property (nonatomic) Alignment subTitleAlignment;
@property (nonatomic) float subTitleFontSize;
@property (nonatomic,strong) NSString* subTitleFontName;
//LEFT NAVIGATION RELATED BUTTON
@property (nonatomic,strong) NSString* leftButtonImage;
@property (nonatomic) ButtonAction leftButtonAction;
//RIGHT NAVIGATION RELATED BUTTON
@property (nonatomic) ButtonAction rightButtonAction;
@property (nonatomic,strong) NSString* rightButtonImage;
//Header Background Image
@property (nonatomic,strong) NSString* backgroundImage;
@property (nonatomic,strong) NSString* backgroundColor;
//Header Height Percentage if Custom
@property (nonatomic) float headerScreenPercent;
@end

NS_ASSUME_NONNULL_END

