//
//  MusicScannerViewController.m
//  MusicScanner
//
//  Created by cybercom on 09-12-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MusicScannerViewController.h"
#import "MusicScanner.h"
#import "MusicMetaDataParser.h"
#import "MusicMetaDataSaver.h"
#import <AudioToolbox/AudioFile.h>


@interface MusicScannerViewController(PrivateMethods)

-(void)scannerButtonPressed:(id)sender;
-(void)parserButtonPressed:(id)sender;
-(void)saveButtonPressed:(id)sender;

@end


@implementation MusicScannerViewController

@synthesize scannerButton;
@synthesize parserButton;
@synthesize saveButton;
@synthesize mediaFilesArray;
@synthesize mediaMetaDataArray;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	UIView *aView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.view = aView;
	[aView release];
	
	//create scannerButton
	self.scannerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	scannerButton.frame = CGRectMake(20.0, 20.0, 150.0, 40.0);
	scannerButton.backgroundColor = [UIColor clearColor];
	[scannerButton setTitle:@"scan local files" forState:UIControlStateNormal];
	[scannerButton addTarget:self action:@selector(scannerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:scannerButton];
	
	
	//create parserButton
	self.parserButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	parserButton.frame = CGRectMake(20.0, 70.0, 150.0, 40.0);
	parserButton.backgroundColor = [UIColor clearColor];
	[parserButton setTitle:@"parser local files" forState:UIControlStateNormal];
	[parserButton addTarget:self action:@selector(parserButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:parserButton];
	
	
	//create parserButton
	self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	saveButton.frame = CGRectMake(20.0, 120.0, 150.0, 40.0);
	saveButton.backgroundColor = [UIColor clearColor];
	[saveButton setTitle:@"save nusic data" forState:UIControlStateNormal];
	[saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:saveButton];
	
	
	//copy resouces music files to application document directory.
	[MusicScanner copyMusicFilesToDocumentDirectoryFromBundle];
	
}


-(void)scannerButtonPressed:(id)sender {
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	if ([documentPaths count] > 0) {
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		NSLog(@"documentsDir = %@", documentsDir);
		self.mediaFilesArray = [MusicScanner searchMediaFile:documentsDir];
		/*
		for (NSString *path in mediaFilesArray) {
			NSLog(@"path = %@", path);
		}*/
	}
	
}

-(void)parserButtonPressed:(id)sender {
	NSDictionary *metaData;
	MusicMetaDataParser *musicParser = [[MusicMetaDataParser alloc] init];
	//NSFileManager *fileManager = [NSFileManager defaultManager];
	self.mediaMetaDataArray = [NSMutableArray array];
	for (NSString *path in mediaFilesArray) {
		NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:path];
		metaData = [musicParser getMusicMetaData:fileURL];
		//album	
		NSString *album = [metaData objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Album]];
		NSLog(@"album = %@", album);
		
		//artist
		NSString *artist = [metaData objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Artist]];
		NSLog(@"artist = %@", artist);
		
		//year
		NSString *year = [metaData objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Year]];
		NSLog(@"year = %@", year);
		
		[mediaMetaDataArray addObject:metaData];
		[fileURL release];
	}
	[musicParser release];
	
}


-(void)saveButtonPressed:(id)sender {
	NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"andios" ofType:@"db"];
	NSLog(@"databasePath = %@", databasePath);
	MusicMetaDataSaver *dataSaver = [[MusicMetaDataSaver alloc] initWithDatabasePath:databasePath];
	//if ([dataSaver openDatabase]) {
		NSLog(@"open database success.");
		/*
		for (NSDictionary *metaData in mediaMetaDataArray) {
			[dataSaver insertAlbumData:metaData];
			break;
		}*/
		[dataSaver insertAlbumData:nil];
		//[dataSaver readAlbumData];
		//[dataSaver closeDatabase];
	//}
	[dataSaver release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)dealloc {
	[scannerButton release];
	[parserButton release];
	[saveButton release];
	[mediaFilesArray release];
	[mediaMetaDataArray release];
    [super dealloc];
}


@end
