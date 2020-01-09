//
//  MFSDKProperties.h
//  MFSDKCoreKit
//
//  Created on 1/30/17.
//  Copyright © 2017 ActiveAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFSDKHeader.h"
typedef NS_ENUM(NSUInteger, SpeechProvider) {
    SpeechProviderGoogle = 531,
    SpeechProviderNative = 532,
};
@interface MFSDKSessionProperties : NSObject
@property(nonatomic,strong)NSString *pageContextId;
@property(nonatomic,strong)NSDictionary *staticMessages;
@property(nonatomic,strong)NSDictionary *userInfo;
//VoiceSDK
@property(nonatomic,strong)NSString *speechAPIKey;
@property(nonatomic,strong)NSString *speechToTextLanguage;
@property(nonatomic,strong)NSString *textToSpeechLanguage;
@property(nonatomic,strong)NSString *extraCustomerJsonInformation;
@property(nonatomic,strong)NSDictionary *pushData;
@property(nonatomic,strong)NSString *inDataExtraInformation;
@property(nonatomic,strong)NSString *language;
@property(nonatomic,assign)BOOL shouldSupportMultiLanguage;
@property (nonatomic) SpeechProvider speechProviderForVoice;
-(void)setHeader:(MFSDKHeader*)header;
-(MFSDKHeader*)getHeader;
@end
