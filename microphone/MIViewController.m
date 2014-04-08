//
//  MIViewController.m
//  microphone
//
//  Created by Olivier Delecueillerie on 28/01/2014.
//  Copyright (c) 2014 Olivier Delecueillerie. All rights reserved.
//

#import "MIViewController.h"
#import "MIMicrophoneUI.h"

@interface MIViewController ()

enum mode
{
    play = 0,
    stop = 1,
    record = 2,
    //stopRecord = 3,
};

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
//@property (weak, nonatomic) IBOutlet F3BarGauge *barGauge;
@property (nonatomic) enum mode mode;
@property (strong, nonatomic) AVAudioPlayer *player;
//@property (strong, nonatomic) AVAudioRecorder *recorder;
@end

@implementation MIViewController

//typedef enum mode mode;

//Lazy instantiation


- (IBAction)switchEditing:(UISwitch *)sender {
    self.editing = sender.on;
}

//setter of the editing property
- (void) setEditing:(BOOL)editing {
    if (editing) {
        //self.barGauge.hidden = NO;
        [self buttonState:record];
    }
    else {
        //self.barGauge.hidden  = YES;
        [self buttonState:play];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// VC LIFECYCLE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];

    //init the default state of the button
    [self buttonState:play];

    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CONTROL
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) buttonState:(NSUInteger) state {
    [self.button removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    switch (state) {
        case 0:
        {
            //play
            [self.button setImage:[UIImage imageNamed:@"buttonPlay"] forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(controlPlay:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 1:
        {
            //stop playing
            [self.button setImage:[UIImage imageNamed:@"buttonStop64"] forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(controlStop:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 2:
        {
            //activated recorder
            [self.button setImage:[UIImage imageNamed:@"microphone64"] forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(controlRecord:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (IBAction)controlRecord:(id)sender {
//open MIMicrophone
    MIMicrophoneUI *microphoneVC = (MIMicrophoneUI *) [self.storyboard instantiateViewControllerWithIdentifier:@"microphone"];
    microphoneVC.delegate = self;
    //microphoneVC.dataNewSound = self.sound;
    [self presentViewController:microphoneVC animated:YES completion:^{
        //code
    }];
}

- (IBAction)controlStop:(id)sender {
    [self.player stop];
    [self buttonState:play];
}

- (IBAction)controlPlay:(id)sender {
    //self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.activatedRecorder.trimmedRecordUrl error:nil];
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithData:self.dataSoundRecorded error:&error];
    [self.player setDelegate:self];
    [self.player play];
    [self buttonState:stop];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AVAudioRecorder delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{

}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self buttonState:play];
}
@end
