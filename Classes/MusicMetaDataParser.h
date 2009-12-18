//
//  MusicMetaData.h
//  MusicScanner
//
//  Created by cybercom on 09-12-17.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MusicMetaDataParser : NSObject {

}

-(id)init;
-(NSDictionary *)getMusicMetaData:(NSURL *)fileURL;

@end
