//
//  MusicMetaData.m
//  MusicScanner
//
//  Created by cybercom on 09-12-17.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MusicMetaDataParser.h"
#import <AudioToolbox/AudioToolbox.h>



@implementation MusicMetaDataParser


-(id)init {
	if (self = [super init]) {
		/*do something*/
	}
	return self;
}


-(NSDictionary *)getMusicMetaData:(NSURL *)fileURL {
	AudioFileID fileID  = nil;
    OSStatus err        = noErr;
    
    err = AudioFileOpenURL( (CFURLRef) fileURL, kAudioFileReadPermission, 0, &fileID );
    if( err != noErr ) {
        NSLog( @"AudioFileOpenURL failed" );
    }	
	
	
	CFDictionaryRef piDict = nil;
    UInt32 piDataSize   = sizeof( piDict );
	
    err = AudioFileGetProperty( fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict );
    if( err != noErr ) {
        NSLog( @"AudioFileGetProperty failed for property info dictionary" );
    }
	
	NSLog( @"property info: %@", (NSDictionary*)piDict );

	
	NSDictionary *metaData = [NSDictionary dictionaryWithDictionary:(NSDictionary*)piDict];
	
   	CFRelease( piDict );
	
	
	return metaData;

}

@end
