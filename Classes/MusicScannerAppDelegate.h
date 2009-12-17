//
//  MusicScannerAppDelegate.h
//  MusicScanner
//
//  Created by cybercom on 09-12-16.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicScannerViewController.h"

@interface MusicScannerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MusicScannerViewController *scannerController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MusicScannerViewController *scannerController;

@end

