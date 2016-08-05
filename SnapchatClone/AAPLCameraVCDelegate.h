//
//  Header.h
//  SnapchatClone
//
//  Created by Alexander Kaplan on 8/1/16.
//  Copyright © 2016 develop. All rights reserved.
//

#ifndef Header_h
#define Header_h

@protocol AAPLCameraVCDelegate <NSObject>

-(void)shouldEnableRecordUI:(BOOL)enable;
-(void)shouldEnableCameraUI:(BOOL)enable;
-(void)canStartRecording;
-(void)recordingHasStarted;
-(void)videoRecordingComplete:(NSURL*)videoURL;
-(void)videoRecordingFailed;
-(void)snapshotTaken:(NSData*)snapshotData;
-(void)snapshotFailed;
@end

#endif /* Header_h */
