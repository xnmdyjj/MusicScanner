//
//  MusicMetaDataSaver.h
//  MusicScanner
//
//  Created by cybercom on 09-12-18.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MusicMetaDataSaver : NSObject {
	
	NSString *databasePath;
}

@property (nonatomic, retain) NSString *databasePath;

- (id)initWithDatabasePath:(NSString *)theDatabasePath;
//-(BOOL)openDatabase;
-(void)readAlbumData;
-(void)insertAlbumData:(NSDictionary *)audioMetaData;
/*
-(void)insertArtistData:(NSDictionary *)audioMetaData;
-(void)insertAudioGenreData:(NSDictionary *)audioMetaData;
-(void)insertAudioMetaData:(NSDictionary *)audioMetaData;

-(void)closeDatabase;*/

@end
