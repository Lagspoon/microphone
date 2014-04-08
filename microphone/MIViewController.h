//
//  MIViewController.h
//  microphone
//
//  Created by Olivier Delecueillerie on 28/01/2014.
//  Copyright (c) 2014 Olivier Delecueillerie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MIMicrophoneUI.h"

@interface MIViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate, microphoneDelegate>

@property (strong, nonatomic) NSData *dataSoundRecorded;
@end