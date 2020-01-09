//
//  MFSpeechIntent.h
//  MFSDKVoiceKit
//
//  Created by ActiveAI on 25/10/17.
//  Copyright © 2017 ActiveAI. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    MFNone = 0,
    MFRecognised = 1,
    MFButtonAction = 2,
    MFScreenAction = 3,
    MFMute = 4,
    MFStopListening = 5,
    MFPrevious,
    MFNext,
    MFSendLocation,
    MFPauseListening,
    MFResumeListening,
    MFOther
};
typedef NSUInteger MFSpeechAction;

@interface MFSpeechIntent : NSObject

@property (strong, nonatomic) NSString *vPayLoad;
@property (nonatomic, assign) MFSpeechAction vSpeechAction;
@property (strong, nonatomic) NSString *vPayLoadAction;
@property (nonatomic, assign) BOOL isFinal;
@end
