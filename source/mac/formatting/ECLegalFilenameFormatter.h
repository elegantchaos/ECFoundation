// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>


@interface ECLegalFilenameFormatter : NSFormatter 
{
	// --------------------------------------------------------------------------
	// Member Variables
	// --------------------------------------------------------------------------

	NSCharacterSet* mIllegalCharacters;
}

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (BOOL) illegalCharactersInString: (NSString*) string;

@end

