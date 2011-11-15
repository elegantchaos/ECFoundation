// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECAnalyticsEngine.h"
#import "ECAnalyticsBackEnd.h"

#import "ECAnalyticsEvent.h"
#import "ECAnalyticsLogging.h"
#import "ECAnalyticsEventTarget.h"
#import "ECAnalyticsStandardKeys.h"

// A note about event encoding:
// This mechanism is provided so that externally an analytics event can always be represented as
// an single name plus a series of parameters, even though internally some of the parameters
// may be encoded into the event name.
//
// By default, events are just left untouched. However, by calling setEncodingParameters:forEventName:,
// you can supply a list of properties that will be added to the raw event name.
//
// So, for example, if you set the encoding parameters for the "Article Viewed" event to a list containing
// "Edition Date", then supplied a value for of "01/02/2011" for the "Edition Date" parameter, the event name
// would turn into "Article Viewed - 20110201".


#pragma mark - Globals

static ECAnalyticsEngine* gExceptionAnalyticsEngine = nil;
static NSUncaughtExceptionHandler* gPreviousExceptionHandler = nil;

#pragma mark - Prototypes

static void uncaughtExceptionHandler(NSException *exception);



@interface ECAnalyticsEngine()

#pragma mark - Private Properties

@property (retain, nonatomic) NSMutableSet* events;
@property (retain, nonatomic) NSMutableDictionary* eventNameMappings;
@property (retain, nonatomic) ECAnalyticsBackEnd* backEnd;

#pragma mark - Private Methods

- (NSString*)encodedEventForName:(NSString*)unmappedName parameters:(NSDictionary*)parameters;
- (void)installDefaultExceptionHandler;
- (void)uninstallDefaultExceptionHandler;

@end


@implementation ECAnalyticsEngine

#pragma mark - Properties

@synthesize debugLevel;
@synthesize events;
@synthesize eventNameMappings;
@synthesize backEnd;

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Set up using the supplied back end.
// --------------------------------------------------------------------------

- (id)initWithBackEnd:(ECAnalyticsBackEnd*)backEndIn
{
    if ((self = [super init]) != nil)
    {
        self.backEnd = backEndIn;
    }
    
    ECDebug(AnalyticsChannel, @"created analytics engine with back end: %@", backEndIn);
    return self;
}

// --------------------------------------------------------------------------
//! Set up using a new back end of the supplied class.
// --------------------------------------------------------------------------

- (id)initWithBackEndClass:(Class)backEndClass
{
    ECAnalyticsBackEnd* newBackEnd = [[[backEndClass alloc] init] autorelease];
    
    return [self initWithBackEnd:newBackEnd];
}

// --------------------------------------------------------------------------
//! Set up using a new back end of the named class.
// --------------------------------------------------------------------------

- (id)initWithBackEndNamed:(NSString*)backEndClassName
{
    // default to the logging engine if one wasn't supplied
    if ([backEndClassName length] == 0)
    {
        backEndClassName = @"ECAnalyticsEngineLogging";
    }
    
    Class backEndClass = NSClassFromString(backEndClassName);
    ECAssertNonNil(backEndClass);
    
    return [self initWithBackEndClass:backEndClass];
}


// --------------------------------------------------------------------------
//! Clean up and release retained objects.
// --------------------------------------------------------------------------

- (void)dealloc
{
    [backEnd release];
    [events release];
    [eventNameMappings release];
	
	[super dealloc];
}

#pragma mark - Management

// --------------------------------------------------------------------------
//! Perform one-time initialisation of the engine.
// --------------------------------------------------------------------------

- (void)startupInstallingExceptionHandler:(BOOL)instalExceptionHandler
{
	[self.backEnd startupWithEngine:self];
	self.events = [[[NSMutableSet alloc] init] autorelease];
    
    if (instalExceptionHandler && (![self.backEnd hasOwnExceptionHandler]))
    {
        [self installDefaultExceptionHandler];
    }
 }

// --------------------------------------------------------------------------
//! Perform one-time cleanup of the engine.
// --------------------------------------------------------------------------

- (void)shutdown
{
	[self.backEnd shutdown];
	
	if ([self.events count] > 0)
	{
		ECDebug(AnalyticsChannel, @"events still being tracked - all events should be finished by now");
	}
	
    if (![backEnd hasOwnExceptionHandler])
    {
        [self uninstallDefaultExceptionHandler];
    }
    
	self.events = nil;
    self.backEnd = nil;
}

// --------------------------------------------------------------------------
//! Suspend the engine (typically called when the application goes into the background)
// --------------------------------------------------------------------------

- (void)suspend
{
    [self.backEnd suspend];
}

// --------------------------------------------------------------------------
//! Resume the engine (typically called when the application returns to the foreground)
// --------------------------------------------------------------------------

- (void)resume
{
    [self.backEnd resume];
}

#pragma mark - Event name encoding

// --------------------------------------------------------------------------
//! Return the encoded name to use for a given event.
// --------------------------------------------------------------------------

- (NSString*)encodedEventForName:(NSString*)unmappedName parameters:(NSDictionary*)parameters 
{
    NSString* result;
    NSArray* mappings = [self.eventNameMappings objectForKey:unmappedName];
    if (mappings) {
        NSMutableString* name = [NSMutableString stringWithString: unmappedName];
        for (NSString* parameter in mappings) {
            NSObject* value = [parameters objectForKey:parameter];
            if (value) {
                [name appendFormat: @" - %@", value];
            }
        }
        result = name;
    }
    else {
        result = unmappedName;
    }
    
    return result;
}

// --------------------------------------------------------------------------
//! Set the list of parameters to encode into a given event name.
//! See above for an explanation of event encoding.
// --------------------------------------------------------------------------

- (void)setEncodingParameters:(NSArray*)parameters forEventName:(NSString*)eventName 
{
    NSMutableDictionary* mappings = self.eventNameMappings;
    if (!mappings)
    {
        mappings = [NSMutableDictionary dictionary];
        self.eventNameMappings = mappings;
    }
    
    [mappings setObject:parameters forKey:eventName];
}

#pragma mark - Logging Interface

// --------------------------------------------------------------------------
//! Given an object, return the event parameters for it.
// --------------------------------------------------------------------------

- (NSMutableDictionary*)parametersForObject:(NSObject*)object forEvent:(NSString*)eventName 
{
    NSMutableDictionary* parameters = nil;
    
    BOOL gotDefaults = [object respondsToSelector:@selector(analyticsAddDefaultParametersForEvent:toDictionary:)];
    BOOL gotDynamics = [object respondsToSelector:@selector(analyticsAddDynamicParametersForEvent:toDictionary:)];
    if (gotDefaults || gotDynamics) 
    {
        NSObject<ECAnalyticsEventTarget>* target = (NSObject<ECAnalyticsEventTarget>*) object;
        parameters = [NSMutableDictionary dictionary];
        if (gotDefaults) 
        {
            [target analyticsAddDefaultParametersForEvent:eventName toDictionary:parameters];
        }
        if (gotDynamics) 
        {
            [target analyticsAddDynamicParametersForEvent:eventName toDictionary:parameters];
        }
    }
                      
    else if ([object isKindOfClass:[NSDictionary class]]) 
    {
        parameters = [[(NSDictionary*) object mutableCopy] autorelease];
    }

    else
    {
        parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      [object description], ECAnalyticsNameParameter,
                      nil];
    }
    return parameters;
}

// --------------------------------------------------------------------------
//! Log an un-timed event.
// --------------------------------------------------------------------------

- (void)logUntimedEvent:(NSString*)eventName forObject:(id)object
{
    NSMutableDictionary* parameters = [self parametersForObject:object forEvent:eventName];
    NSString* encodedEvent = [self encodedEventForName:eventName parameters:parameters];
	[self.backEnd untimedEvent:encodedEvent forObject:object parameters:parameters];
}

// --------------------------------------------------------------------------
//! Start logging a timed event. Returns the event, which can be ended by calling logTimedEventEnd:
// --------------------------------------------------------------------------

- (ECAnalyticsEvent*)logTimedEventStart:(NSString*)eventName forObject:(id)object
{
    NSMutableDictionary* parameters = [self parametersForObject:object forEvent:eventName];
    NSString* encodedEvent = [self encodedEventForName:eventName parameters:parameters];
	ECAnalyticsEvent* event = [self.backEnd timedEventStart:encodedEvent forObject:object parameters:parameters];
	[self.events addObject: event];
	
	return event;
}

// --------------------------------------------------------------------------
//! Finish logging a timed event.
// --------------------------------------------------------------------------

- (void)logTimedEventEnd:(ECAnalyticsEvent*)event
{
    // add duration parameter
    [event updateParameters:[NSDictionary dictionaryWithObject:[event elapsedTimeSinceStartQuantised] forKey: ECAnalyticsDurationParameter]];

	[self.backEnd timedEventEnd: event];
	
	if (![self.events containsObject: event])
	{
		ECDebug(AnalyticsChannel, @"event %@ is not being tracked", event.name);
	}
	
	[self.events removeObject: event];
}

// --------------------------------------------------------------------------
//! Log an NSError.
// --------------------------------------------------------------------------

- (void)logError:(NSError*)errorOrNil message:(NSString*)messageOrNil
{
    if (!messageOrNil) 
    {
        if (errorOrNil) 
        {
            messageOrNil = [NSString stringWithFormat:@"%@ (%d): %@", [errorOrNil domain], [errorOrNil code], [errorOrNil localizedDescription]];
        }
        else 
        {
            messageOrNil = [NSString stringWithFormat:@"%@ (%d)", [errorOrNil domain], [errorOrNil code]];
        }
    }
    
    if (!errorOrNil) 
    {
        errorOrNil = [NSError errorWithDomain:@"Generic Error" code:1 userInfo:[NSDictionary dictionaryWithObject:messageOrNil forKey:@"Message"]];
    }
                      
    [self.backEnd error:errorOrNil message:messageOrNil];
}

// --------------------------------------------------------------------------
//! Log an exception.
// --------------------------------------------------------------------------

- (void)logException:(NSException*)exception
{
	[self.backEnd exception: exception];
}

#pragma mark - Exception Handling

// --------------------------------------------------------------------------
//! Called for uncaught exceptions.
// --------------------------------------------------------------------------

void uncaughtExceptionHandler(NSException *exception) 
{
	[gExceptionAnalyticsEngine logException:exception];
    if (gPreviousExceptionHandler)
    {
        gPreviousExceptionHandler(exception);
    }
}

// --------------------------------------------------------------------------
//! Install our default exception handler.
// --------------------------------------------------------------------------

- (void)installDefaultExceptionHandler
{
    if (gExceptionAnalyticsEngine == nil)
    {
        gExceptionAnalyticsEngine = self;
        gPreviousExceptionHandler = NSGetUncaughtExceptionHandler();
        NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    }
}

// --------------------------------------------------------------------------
//! Remove our default exception handler.
// --------------------------------------------------------------------------

- (void)uninstallDefaultExceptionHandler
{
    if (gExceptionAnalyticsEngine)
    {
        NSSetUncaughtExceptionHandler(gPreviousExceptionHandler);
        gExceptionAnalyticsEngine = nil;
    }
}




@end
