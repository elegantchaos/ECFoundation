// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
//
//  Based on Apple's sample code.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef enum 
{
	NotReachable = 0,
	ReachableViaWiFi,
	ReachableViaWWAN
} NetworkStatus;

extern NSString *const ReachabilityChangedNotification;

@interface ECReachability: NSObject
{
	BOOL localWiFiRef;
	SCNetworkReachabilityRef reachabilityRef;
}

//reachabilityWithHostName- Use to check the reachability of a particular host name. 
+ (ECReachability*) reachabilityWithHostName: (NSString*) hostName;

//reachabilityWithAddress- Use to check the reachability of a particular IP address. 
+ (ECReachability*) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress;

//reachabilityForInternetConnection- checks whether the default route is available.  
//  Should be used by applications that do not connect to a particular host
+ (ECReachability*) reachabilityForInternetConnection;

//reachabilityForLocalWiFi- checks whether a local wifi connection is available.
+ (ECReachability*) reachabilityForLocalWiFi;

//Start listening for reachability notifications on the current run loop
- (BOOL) startNotifier;
- (void) stopNotifier;

- (NetworkStatus) currentReachabilityStatus;
//WWAN may be available, but not active until a connection has been established.
//WiFi may require a connection for VPN on Demand.
- (BOOL) connectionRequired;
@end


