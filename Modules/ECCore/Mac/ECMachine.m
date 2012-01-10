// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 30/11/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECMachine.h"

#import "NSData+ECCore.h"


static CFDataRef copyMacAddress(void);

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECMachine()

@end


@implementation ECMachine

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Methods
// --------------------------------------------------------------------------

// Returns a CFData object, containing the machine's GUID.
CFDataRef copyMacAddress(void)
{
    kern_return_t             kernResult;
    mach_port_t               master_port;
    CFMutableDictionaryRef    matchingDict;
    io_iterator_t             iterator;
    io_object_t               service;
    CFDataRef                 macAddress = nil;
	
    kernResult = IOMasterPort(MACH_PORT_NULL, &master_port);
    if (kernResult != KERN_SUCCESS) {
        printf("IOMasterPort returned %d\n", kernResult);
        return nil;
    }
	
    matchingDict = IOBSDNameMatching(master_port, 0, "en0");
    if(!matchingDict) {
        printf("IOBSDNameMatching returned empty dictionary\n");
        return nil;
    }
	
    kernResult = IOServiceGetMatchingServices(master_port, matchingDict, &iterator);
    if (kernResult != KERN_SUCCESS) {
        printf("IOServiceGetMatchingServices returned %d\n", kernResult);
        return nil;
    }
	
    while((service = IOIteratorNext(iterator)) != 0)
    {
        io_object_t        parentService;
		
        kernResult = IORegistryEntryGetParentEntry(service, kIOServicePlane, &parentService);
        if(kernResult == KERN_SUCCESS)
        {
            if(macAddress) CFRelease(macAddress);
			
            macAddress = IORegistryEntryCreateCFProperty(parentService, CFSTR("IOMACAddress"), kCFAllocatorDefault, 0);
            IOObjectRelease(parentService);
        }
        else {
            printf("IORegistryEntryGetParentEntry returned %d\n", kernResult);
        }
		
        IOObjectRelease(service);
    }
	
	return macAddress;
}

// --------------------------------------------------------------------------
//! Return machine address as data.
// --------------------------------------------------------------------------

+ (NSData*) machineAddress
{
	NSData* guidData = (NSData*) copyMacAddress();
	
	if ([NSGarbageCollector defaultCollector])
		[[NSGarbageCollector defaultCollector] enableCollectorForPointer:guidData];
	else 
		[guidData autorelease];
	
    return guidData;
}

// --------------------------------------------------------------------------
//! Return machine address as a hex string.
// --------------------------------------------------------------------------

+ (NSString*) machineAddressString
{
	NSData* address = [ECMachine machineAddress];
	NSString* string = [address hexString];
	
	return string;
}

@end
