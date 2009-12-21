//
//  MusicScannerAppDelegate.m
//  MusicScanner
//
//  Created by cybercom on 09-12-16.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "MusicScannerAppDelegate.h"

@interface MusicScannerAppDelegate(PrivateMethods)
- (void)createEditableCopyOfDatabaseIfNeeded;
@end

@implementation MusicScannerAppDelegate

@synthesize window;
@synthesize scannerController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[self createEditableCopyOfDatabaseIfNeeded];
	MusicScannerViewController *aController = [[MusicScannerViewController alloc] init];
	self.scannerController = aController;
	[aController release];
	[window addSubview:scannerController.view];
    [window makeKeyAndVisible];
}


- (void)createEditableCopyOfDatabaseIfNeeded {
	
	NSLog(@"Creating editable copy of database");
	// First, test for existence.
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"audios.db"];
	success = [fileManager fileExistsAtPath:writableDBPath];
	if (success) {
		//[fileManager removeItemAtPath:writableDBPath error:nil];
		return;
	}
	// The writable database does not exist, so copy the default to the appropriate location.
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"audios.db"];
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	if (!success) {
		NSAssert1(0, @"Failed to create writable database file with message ‘%@’.", [error localizedDescription]);
	}
}

- (void)dealloc {
	[scannerController release];
    [window release];
    [super dealloc];
}


@end
