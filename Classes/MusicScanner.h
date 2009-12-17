//
//  MusicScanner.h
//  MusicScanner
//
//  Created by cybercom on 09-12-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MusicScanner : NSObject {

}

+(void)copyMusicFilesToDocumentDirectoryFromBundle;
+(NSMutableArray *)searchMediaFile:(NSString *)directoryPath;

@end
