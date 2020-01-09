//
//  MFSpeechKitManager.h
//  MFSDKVoiceKit
//
//  Created by ActiveAI on 25/10/17.
//  Copyright © 2017 ActiveAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MFSpeechProvider.h"
#import "MFSpeechIntent.h"

enum {
    MFSUIIdle = 1,
    MFSUIListening = 2,
    MFSUISpeaking = 3,
};

typedef NSUInteger MFSpeechUIState;

@protocol MFSpeechDelegate <NSObject>
@optional
- (void)onStateChange:(MFSpeechUIState)state;
- (void)onAmplitudeChange:(CGFloat)amplitude;
- (void)onError:(NSError *)error suggestion:(NSString *)suggestion;
- (void)onVoiceHint:(NSArray *)hints;
- (void)onVoiceRecognize:(MFSpeechIntent *)intent;

@end

@interface MFSpeechKitManager : NSObject
- (void)shouldDetectHotPhrase:(BOOL)detect;
- (void)setSpeechRate:(NSString*)speechRate;
- (void)addHotPhraseToResume:(NSString *)phrase;
- (void)addHotPhraseToPause:(NSString *)phrase;
-(void)setTTSLanguageCode:(NSString*)langCode;
-(void)setSTTLanguageCode:(NSString*)langCode;
- (instancetype)initWithDelegate:(id<MFSpeechDelegate>)skResultDelegate providor:(MFSpeechProvider *)providor;
- (void)startRecognition;
- (void)stopRecognition;
- (void)startTTS:(NSString *)speechText;
- (void)stopTTS;
-(BOOL)isTTSInProgress;
- (MFSpeechUIState) currentVoiceState;
- (void)addSuggestion:(NSString *)suggestionData;
- (void)addAction:(NSString *)actionData;
- (MFSpeechIntent *)processSuggestion:(NSString *)suggestionData;
- (NSString *)formatTextToSpeechString:(NSString *)speechToText;
-(BOOL)isSpeechRecogniserAuthorised;
-(BOOL)isVoiceRecogniserAuthorised;

@end
