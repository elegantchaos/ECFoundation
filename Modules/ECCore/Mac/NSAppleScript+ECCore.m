// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 24/03/2011
//
//! Elegant Chaos extensions to NSAppleScript.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSAppleScript+ECCore.h"
#import "NSAppleEventDescriptor+ECCore.h"

#import "ECErrorReporter.h"
#import "ECLogging.h"

#import <Carbon/Carbon.h>

@implementation NSAppleScript(ECCore)

ECDefineDebugChannel(NSAppleScriptChannel);

// --------------------------------------------------------------------------
//! Return compiled script from a file in the main bundle.
// --------------------------------------------------------------------------

+ (NSAppleScript*) scriptNamed:(NSString*)name
{
    return [self scriptNamed:name fromBundle:[NSBundle mainBundle]];
}

// --------------------------------------------------------------------------
//! Return compiled script from a given bundle.
// --------------------------------------------------------------------------

+ (NSAppleScript*) scriptNamed:(NSString*)name fromBundle:(NSBundle*)bundle
{
    NSAppleScript* script = nil;
    
    NSURL* source = [bundle URLForResource:name withExtension:@"scpt"];
    if (!source)
    {
        [ECErrorReporter reportError:nil message:@"couldn't find script resource %@ in bundle %@", name, bundle];
    }
    else
    {
        NSDictionary* error = nil;
        script = [[NSAppleScript alloc] initWithContentsOfURL:source error:&error];
        if (!script)
        {
            [ECErrorReporter reportError:nil message:@"couldn't compile script %@ from bundle %@, error was %@", name, bundle, error];
        }
    }
        
    return [script autorelease];
}

/* callScript is the main workhorse routine we use for calling handlers
 in our AppleScript.  Essentially, this routine creates a 'call subroutine' Apple event
 and then it dispatches the event to the compiled AppleScript we loaded in our awakeFromNib
 routine. */
- (NSAppleEventDescriptor*) callHandler:(NSString *)handlerName withArrayOfParameters:(NSAppleEventDescriptor*) parameterList 
{
	ProcessSerialNumber PSN = {0, kCurrentProcess};
	NSAppleEventDescriptor* theAddress = [NSAppleEventDescriptor descriptorWithDescriptorType:typeProcessSerialNumber bytes:&PSN length:sizeof(PSN)];
	
    /* create the target address descriptor specifying our own process as the target */
	if (theAddress) 
    {
		NSAppleEventDescriptor *theEvent = [NSAppleEventDescriptor appleEventWithEventClass:typeAppleScript eventID:kASSubroutineEvent targetDescriptor:theAddress returnID:kAutoGenerateReturnID transactionID:kAnyTransactionID];
        
        /* create a new Apple event of type typeAppleScript/kASSubroutineEvent */
		if ( theEvent ) 
        {
			NSAppleEventDescriptor* theHandlerName = [NSAppleEventDescriptor descriptorWithString:[handlerName lowercaseString]];
            
            /* create a descriptor containing the handler's name.  AppleScript handler
             names must be converted to lowercase before including them in a call
             subroutine Apple event.  */
			if ( theHandlerName  ) 
            {
				NSDictionary *errorInfo;
				NSAppleEventDescriptor *theResult;
				
                /* add the handler's name to the Apple event using the
                 keyASSubroutineName keyword */
				[theEvent setDescriptor:theHandlerName forKeyword:keyASSubroutineName];
				
                /* add the parameter list.  If none was specified, then create an empty one */
				if ( parameterList != nil )
                {
					[theEvent setDescriptor:parameterList forKeyword:keyDirectObject];
				} else 
                {
					NSAppleEventDescriptor* paramList = [NSAppleEventDescriptor listDescriptor];
					[theEvent setDescriptor:paramList forKeyword:keyDirectObject];
				}
				
                /* send the subroutine event to the script  */
				theResult = [self executeAppleEvent:theEvent error:&errorInfo];
				
                /* if an error happened in the AppleScript, display the error information.  */
				if ( nil == theResult ) 
                {
					NSString* paramStr;
					
                    /* collect the parameters into a string of comma separated values
                     so the user can see what they are */
					if ( parameterList != nil ) 
                    {
						NSArray* theParamStrings = [parameterList stringArrayValue];
						paramStr = [theParamStrings componentsJoinedByString:@", "];
					} else 
                    {
						paramStr = @"";
					}
					
                    [ECErrorReporter reportError:nil message:@"error %@ occured the %@(%@) call: %@",
                                     [errorInfo objectForKey:NSAppleScriptErrorNumber],
                                     handlerName, paramStr,
                                     [errorInfo objectForKey:NSAppleScriptErrorBriefMessage]];
				}
				
                /* return whatever result the script returned */
				return theResult;
			}
		}
	}
	return nil;
}

/* callHandler is a convenience routine that calls through to
 callScript:withArrayOfParameters:.  This method received parameters
 as a variable argument list of Objective-C objects and it automatically
 builds the AEDescList parameter for callScript:withArrayOfParameters: based
 on the types of objects provided as parameters.  Parameters may be NSNumbers,
 NSStrings, or NSAppleEventDescriptors.  */
- (NSAppleEventDescriptor*) callHandler:(NSString *)handlerName withParameters: (id) firstParameter, ... 
{
	va_list args;
	int index = 1;
	id nthID;
	NSAppleEventDescriptor* paramList = [NSAppleEventDescriptor listDescriptor];
	
	va_start(args, firstParameter);
	
	for (nthID=firstParameter; nthID != nil; nthID = va_arg(args, id) ) {
        
		if ( [nthID isKindOfClass: [NSNumber class]] ) {
            
            SInt32 nthID32 = (SInt32) [nthID longValue];
			[paramList insertDescriptor:
             [NSAppleEventDescriptor descriptorWithInt32:nthID32] atIndex:(index++)];
            
		} else if ( [nthID isKindOfClass: [NSString class]] ) {
            
			[paramList insertDescriptor:
             [NSAppleEventDescriptor descriptorWithString:nthID] atIndex:(index++)];
            
		} else if ( [nthID isKindOfClass: [NSAppleEventDescriptor class]] ) {
            
			[paramList insertDescriptor: nthID atIndex:(index++)];
			
		} else {
            
			ECDebug(NSAppleScriptChannel, @"unrecognized parameter type for parameter %d in callHandler:withParameters:", index);
			return nil; /* bad parameter */
			
		}
	}
	
	va_end(args);
	
	return [self callHandler:handlerName withArrayOfParameters:paramList];
}


@end
