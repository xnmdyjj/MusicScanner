//
//  MusicScannerAppDelegate.m
//  MusicScanner
//
//  Created by cybercom on 09-12-16.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "MusicScannerAppDelegate.h"

@implementation MusicScannerAppDelegate

@synthesize window;
@synthesize scannerController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	MusicScannerViewController *aController = [[MusicScannerViewController alloc] init];
	self.scannerController = aController;
	[aController release];
	[window addSubview:scannerController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[scannerController release];
    [window release];
    [super dealloc];
}


@end
