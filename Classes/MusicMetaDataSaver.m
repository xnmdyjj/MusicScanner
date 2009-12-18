//
//  MusicMetaDataSaver.m
//  MusicScanner
//
//  Created by cybercom on 09-12-18.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MusicMetaDataSaver.h"
#import <AudioToolbox/AudioFile.h>
#import <sqlite3.h>


@implementation MusicMetaDataSaver

@synthesize databasePath;

- (id)initWithDatabasePath:(NSString *)theDatabasePath {
	if (self = [super init]) {
		self.databasePath = theDatabasePath;
	}
	return self;
}

/*
-(BOOL)openDatabase {
	if (databasePath) {
		const char *theDatabasePathChar = [databasePath cStringUsingEncoding:NSUTF8StringEncoding];
		if (sqlite3_open(theDatabasePathChar, &database) == SQLITE_OK) {
			return YES;
		}
		sqlite3_close(database);
	}
	return NO;
}*/

#if 1
	
-(void)readAlbumData {
	sqlite3 *database;
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		const char *selectStatement = "select album_key, album from albums";
		sqlite3_stmt *compiledStatement;
		if (sqlite3_prepare_v2(database, selectStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				NSString *albumKey = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *albumName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSLog(@"albumKey = %@", albumKey);
				NSLog(@"albumName = %@", albumName);
			}
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
}

#endif

-(void)insertAlbumData:(NSDictionary *)audioMetaData {
	sqlite3 *database;
	
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		const char *insertStatement = "insert into albums(album_key ,album) values(?,?)";
		sqlite3_stmt *compiledStatement;
		
		if (sqlite3_prepare_v2(database, insertStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
#if 0
			//const char *album_key = "musicscanner";
			NSString *album = [audioMetaData objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Album]];
			NSLog(@"album = %@", album);
			
			if (album) {
				albumName = [album UTF8String];
			}else {
				albumName = NULL;
			}
#endif
			const char *albumName = "Jianjun";
			const char *album_key = "musicscanner";
			sqlite3_bind_text(compiledStatement, 1, album_key, -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, albumName, -1, SQLITE_TRANSIENT);
			if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
				printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
			}
		}else {
			printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(compiledStatement);
		
	}
	
	sqlite3_close(database);
}

#if 0

-(void)insertArtistData:(NSDictionary *)audioMetaData {
	const char *insertStatement = "insert into artists(artist_key ,artist) values('hello1', 'yujianjun1')";
	sqlite3_stmt *compiledStatement;
	if (sqlite3_prepare_v2(database, insertStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		//const char *album_key = "musicscanner";
		//const char *album = "yujianjun";
		//sqlite3_bind_text(compiledStatement, 1, album_key, -1, SQLITE_TRANSIENT);
		//sqlite3_bind_text(compiledStatement, 2, album, -1, SQLITE_TRANSIENT);
		if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
			printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
		}
	}else {
		printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
	}
	
	sqlite3_finalize(compiledStatement);

}

-(void)insertAudioGenreData:(NSDictionary *)audioMetaData {
	const char *insertStatement = "insert into audio_genres(name) values('blue')";
	sqlite3_stmt *compiledStatement;
	if (sqlite3_prepare_v2(database, insertStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		//const char *album_key = "musicscanner";
		//const char *album = "yujianjun";
		//sqlite3_bind_text(compiledStatement, 1, album_key, -1, SQLITE_TRANSIENT);
		//sqlite3_bind_text(compiledStatement, 2, album, -1, SQLITE_TRANSIENT);
		if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
			printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
		}
	}else {
		printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
	}
	
	sqlite3_finalize(compiledStatement);
}

-(void)insertAudioMetaData:(NSDictionary *)audioMetaData {
	
}


-(void)closeDatabase {
	sqlite3_close(database);
}

#endif

-(void)dealloc {
	[databasePath release];
	[super dealloc];
}

@end
