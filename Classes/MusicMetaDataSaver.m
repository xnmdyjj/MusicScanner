//
//  MusicMetaDataSaver.m
//  MusicScanner
//
//  Created by cybercom on 09-12-18.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MusicMetaDataSaver.h"
#import <AudioToolbox/AudioFile.h>


@implementation MusicMetaDataSaver

@synthesize databasePath;
@synthesize database;

- (id)initWithDatabasePath:(NSString *)theDatabasePath {
	if (self = [super init]) {
		self.databasePath = theDatabasePath;
	}
	return self;
}


-(BOOL)openDatabase {
	if (databasePath) {
		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
			return YES;
		}
		sqlite3_close(database);
	}
	return NO;
}



-(void)readAlbumData {
	const char *selectStatement = "select album_key, album from albums";
	sqlite3_stmt *compiledStatement;
	if (sqlite3_prepare_v2(database, selectStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSString *albumKey = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
			NSLog(@"albumKey = %@", albumKey);
			char *albumName = (char *)sqlite3_column_text(compiledStatement, 1);
			if (albumName) {
				NSLog(@"albumName = %@", [NSString stringWithUTF8String:albumName]);
			} else {
				NSLog(@"albumName = null");
			}
			
		}
	}
	sqlite3_finalize(compiledStatement);
}


-(void)insertAlbumData:(NSDictionary *)audioMetaData {
	const char *insertStatement = "insert into albums(album_key ,album) values(?,?)";
	sqlite3_stmt *compiledStatement;	
	if (sqlite3_prepare_v2(database, insertStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		static int i = 0;
		NSString *albumKey = [NSString stringWithFormat:@"album_key%d", i];
		const char *album_key = [albumKey UTF8String];
		i++;
		sqlite3_bind_text(compiledStatement, 1, album_key, -1, SQLITE_TRANSIENT);
		
		NSString *albumName = [audioMetaData objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Album]];
		
		if (albumName) {
			sqlite3_bind_text(compiledStatement, 2, [albumName UTF8String], -1, SQLITE_TRANSIENT);
		} else {
			sqlite3_bind_null(compiledStatement, 2);
		}		
		
		
		if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
			printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
		}
		else {
			NSLog(@"insert success");
		}
		
	}else {
		printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
	}
	
	sqlite3_finalize(compiledStatement);

}




-(void)insertArtistData:(NSDictionary *)audioMetaData {
	const char *insertStatement = "insert into artists(artist_key ,artist) values(?, ?)";
	sqlite3_stmt *compiledStatement;
	if (sqlite3_prepare_v2(database, insertStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		static int i = 0;
		NSString *artistKey = [NSString stringWithFormat:@"artist_key%d", i];
		const char *artist_key = [artistKey UTF8String];
		i++;
		sqlite3_bind_text(compiledStatement, 1, artist_key, -1, SQLITE_TRANSIENT);
		
		NSString *artistName = [audioMetaData objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Artist]];
		if (artistName) {
			sqlite3_bind_text(compiledStatement, 2, [artistName UTF8String], -1, SQLITE_TRANSIENT);
		} else {
			sqlite3_bind_null(compiledStatement, 2);
		}		
				
		if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
			printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
		}
		else {
			NSLog(@"insert success");
		}
		
	}else {
		printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
	}
	
	sqlite3_finalize(compiledStatement);

}

-(void)insertAudioGenreData:(NSDictionary *)audioMetaData {
	const char *insertStatement = "insert into audio_genres(name) values(?)";
	sqlite3_stmt *compiledStatement;
	if (sqlite3_prepare_v2(database, insertStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		
		NSString *genreName = [audioMetaData objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Genre]];
		if (genreName) {
			sqlite3_bind_text(compiledStatement, 1, [genreName UTF8String], -1, SQLITE_TRANSIENT);
		} else {
			sqlite3_bind_null(compiledStatement, 1);
		}		
		
		if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
			printf("Error: failed to insert into the database with message : %s\n", sqlite3_errmsg(database));
		}
		else {
			NSLog(@"insert success");
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


-(void)dealloc {
	[databasePath release];
	[super dealloc];
}

@end
