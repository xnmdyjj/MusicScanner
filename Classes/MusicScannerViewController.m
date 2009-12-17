//
//  MusicScannerViewController.m
//  MusicScanner
//
//  Created by cybercom on 09-12-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MusicScannerViewController.h"
#import "MusicScanner.h"


@interface MusicScannerViewController(PrivateMethods)

-(void)scannerButtonPressed:(id)sender;

@end


@implementation MusicScannerViewController

@synthesize scannerButton;

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
	
	//create itemsGetButton
	self.scannerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	scannerButton.frame = CGRectMake(20.0, 20.0, 150.0, 40.0);
	scannerButton.backgroundColor = [UIColor clearColor];
	[scannerButton setTitle:@"scan local files" forState:UIControlStateNormal];
	[scannerButton addTarget:self action:@selector(scannerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:scannerButton];
	
	
	//copy resouces music files to application document directory.
	[MusicScanner copyMusicFilesToDocumentDirectoryFromBundle];
	
}


-(void)scannerButtonPressed:(id)sender {
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	if ([documentPaths count] > 0) {
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		NSLog(@"documentsDir = %@", documentsDir);
		NSArray *mediaFilesArray = [MusicScanner searchMediaFile:documentsDir];
		for (NSString *path in mediaFilesArray) {
			NSLog(@"path = %@", path);
		}
		
	}
	
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
    [super dealloc];
}


@end
