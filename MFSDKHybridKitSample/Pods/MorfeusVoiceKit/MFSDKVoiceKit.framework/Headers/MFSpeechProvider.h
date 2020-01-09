//
//  MFSpeechProvidor.h
//  MFSDKVoiceKit
//
//  Created by ActiveAI on 25/10/17.
//  Copyright © 2017 ActiveAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// State Logic: IDLE -> LISTENING -> PROCESSING -> repeat
enum {
    MFGoogleSpeechProvidor = 1,
    MFNuanceSpeechProvidor = 2,
    MFAppleNativeSpeechProvidor = 3
};
typedef NSUInteger MFSpeechProviderType;

@interface MFSpeechProvider : NSObject

- (instancetype)initWithProvider:(MFSpeechProviderType)providerType;
- (void)setVoiceLanguage:(NSString *)language;
- (void)setGoogleVoiceAPIKey:(NSString *)apiKey;
- (void)setNuanceVoiceAPIKey:(NSString *)apiKey appId:(NSString *)appId;

- (MFSpeechProviderType)getProviderType;
- (NSString *)getGoogleKey;
- (NSString *)getVoiceLanguage;
- (BOOL)isProviderGoogle;
@property(nonatomic,assign) CGFloat speechConfidenceThreshold;
@property(nonatomic,assign) NSInteger maxHint;
@property(nonatomic,assign) BOOL enableHint;
- (BOOL)isProviderApple;
@end
