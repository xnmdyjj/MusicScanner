//
//  MusicScannerViewController.h
//  MusicScanner
//
//  Created by cybercom on 09-12-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MusicScannerViewController : UIViewController {
	UIButton *scannerButton;
	UIButton *parserButton;
	UIButton *saveButton;
	NSArray *mediaFilesArray;
	NSMutableArray *mediaMetaDataArray;
}

@property (nonatomic, retain) UIButton *scannerButton;
@property (nonatomic, retain) UIButton *parserButton;
@property (nonatomic, retain) UIButton *saveButton;
@property (nonatomic, retain) NSArray *mediaFilesArray;
@property (nonatomic, retain) NSArray *mediaMetaDataArray;

@end
