//
//  MIMicrophoneUI.h
//  microphone
//
//  Created by Olivier Delecueillerie on 31/03/2014.
//  Copyright (c) 2014 Olivier Delecueillerie. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "FDSoundActivatedRecorder.h"

@protocol microphoneDelegate <NSObject>
@optional
@property (nonatomic, strong) NSData *dataSoundRecorded;

@end

@interface MIMicrophoneUI : UIViewController <FDSoundActivatedRecorderDelegate>

//@property (strong, nonatomic) NSData *dataNewSound;
@property (strong, nonatomic) id <microphoneDelegate> delegate;
@end
