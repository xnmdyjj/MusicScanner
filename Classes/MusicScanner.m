//
//  MusicScanner.m
//  MusicScanner
//
//  Created by cybercom on 09-12-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MusicScanner.h"


@implementation MusicScanner

/*
 copy bunfle files to application document directory
 */

+(void)copyMusicFilesToDocumentDirectoryFromBundle {
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	if ([documentPaths count] > 0) {
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		NSString *oneMusicDocPath = [documentsDir stringByAppendingPathComponent:@"audiofile.mp3"];
		NSString *anotherMusicDocPath = [documentsDir stringByAppendingPathComponent:@"Hot.mp3"];
		NSString *oneMusicBundlePath = [[NSBundle mainBundle] pathForResource:@"audiofile" ofType:@"mp3"];
		NSString *anotherMusicBundlePath = [[NSBundle mainBundle] pathForResource:@"Hot" ofType:@"mp3"];
		
		NSString *threeMusicBundlePath = [[NSBundle mainBundle] pathForResource:@"daoxiang" ofType:@"mp3"];
		NSString *musicPath = [documentsDir stringByAppendingPathComponent:@"music"];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
									  
		if ([fileManager fileExistsAtPath:musicPath]) {
			NSString *threeMusicDocPath = [musicPath stringByAppendingPathComponent:@"daoxiang.mp3"];
			if (![fileManager fileExistsAtPath:threeMusicDocPath]) {
				[fileManager copyItemAtPath:threeMusicBundlePath toPath:threeMusicDocPath error:nil];
			}

		}else {
			[fileManager createDirectoryAtPath:musicPath attributes:nil];
		}
		
		if (![fileManager fileExistsAtPath:oneMusicDocPath]) {
			[fileManager copyItemAtPath:oneMusicBundlePath toPath:oneMusicDocPath error:nil];
		}
		if (![fileManager fileExistsAtPath:anotherMusicDocPath]) {
			[fileManager copyItemAtPath:anotherMusicBundlePath toPath:anotherMusicDocPath error:nil];
		}
	}
		
	
}

/*
 Search audio files in the path, And return an array
*/

+(NSMutableArray *)searchMediaFile:(NSString *)directoryPath{
	NSMutableArray *mediaFilesArray = [NSMutableArray array];
	NSDirectoryEnumerator *directoryEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:directoryPath];
	for (NSString *path in directoryEnumerator) {
		if ([[path pathExtension] isEqualToString:@"mp3"]) {
			[mediaFilesArray addObject:[directoryPath stringByAppendingPathComponent:path]];
		}
		if ([[path pathExtension] isEqualToString:@"3gp"]) {
			[mediaFilesArray addObject:[directoryPath stringByAppendingPathComponent:path]];
		}
	}
	return mediaFilesArray;
}


-(void)dealloc {
	[super dealloc];
}

@end
