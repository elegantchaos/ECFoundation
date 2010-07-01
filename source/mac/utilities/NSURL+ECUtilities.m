// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSURL+ECUtilities.h"


@implementation NSURL(ECUtilities)

// --------------------------------------------------------------------------
//! Get a unique name to use for a file in a folder, using the default
//! file manager.
// --------------------------------------------------------------------------

- (NSURL*) getUniqueFileWithName: (NSString*) name andExtension: (NSString*) extension
{
	return [self getUniqueFileWithName: name andExtension: extension usingManager: [NSFileManager defaultManager]];
}
			
// --------------------------------------------------------------------------
//! Get a unique name to use for a file in a folder.
//! If the file "name.extension" doesn't exist, we just use it. Otherwise
//! we try "name 1.extension", "name 2.extension" and so on, until we find
//! one that doesn't exist.
// --------------------------------------------------------------------------

- (NSURL*) getUniqueFileWithName: (NSString*) name andExtension: (NSString*) extension usingManager: (NSFileManager*) fileManager
{
	NSInteger iteration = 0;
	NSURL* result;
	NSString* newName = name;
	do
	{
		result = [[self URLByAppendingPathComponent:newName] URLByAppendingPathExtension: extension];
		newName = [NSString stringWithFormat: @"%@ %d", name, ++iteration];
	} while ([fileManager fileExistsAtPath: [result path]]);
	
	return result;
}
@end
