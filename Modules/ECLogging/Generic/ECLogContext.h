// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#ifdef __OBJC__

@class ECLogChannel;

#else

typedef void ECLogChannel;

#endif

#ifdef __cplusplus
extern "C"
{
#endif
    
    typedef enum
    {
        ECLogContextNone        = 0x0000,
        ECLogContextFile        = 0x0001,
        ECLogContextDate        = 0x0002,
        ECLogContextFunction    = 0x0004,
        ECLogContextMessage     = 0x0008,
        ECLogContextName        = 0x0010,
        
        ECLogContextFullPath    = 0x1000,
        ECLogContextDefault     = 0x8000
    } ECLogContextFlags;
    
    typedef struct 
    {
        const char* file;
        unsigned int line;
        const char* date;
        const char* function;
    } ECLogContext;
    
    extern void makeContext(ECLogContext* context, const char* file, unsigned int line, const char* date, const char* function);
    extern void enableChannel(ECLogChannel* channel);
    extern void disableChannel(ECLogChannel* channel);
    extern bool channelEnabled(ECLogChannel* channel);
    extern ECLogChannel* registerChannel(const char* name);
    extern void	logToChannel(ECLogChannel* channel, ECLogContext* context, NSString* format, ...);
    
#ifdef __cplusplus
}
#endif

#define ECMakeContext() ECLogContext ecLogContext; makeContext(&ecLogContext, __FILE__, __LINE__, __DATE__, __PRETTY_FUNCTION__)

