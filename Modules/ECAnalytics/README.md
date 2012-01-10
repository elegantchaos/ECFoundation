What's This?
============

This framework implements an abstraction of an Analytics / Crash Reporting framework,
and provides various back-end implementations using different engines.

Pretty much every engine uses a slightly different model, so we provide a fairly high
level abstraction, and leave the back-end implementations to do their best to map it.

In our abstraction there are three main areas:

- event reporting
- error reporting
- exception / crash reporting


Events
------

Events happen to an object, and are abstracted as having a name and a dictionary of parameters. 

You can either log an untimed event (which just "happens"), or you can
log the start of the event (which gives you back an object to store), and later use
the object to log the end of the event.


Errors
------

Errors can be reported as an NSError object plus an optional message.


Exceptions / Crashes
--------------------

Exceptions can be reported explicitly (as an NSException object). The abstract engine will 
also optionally install a handler to catch uncaught exceptions. This is made optional
because some of the back-end implementations already do this themselves.


Event Encoding
--------------

Events are represented as a name plus a dictionary of parameters. However, some back-end
implementations can only represent events as a single string.

The event encoding mechanism is provided so that the values some parameters on an event
can automatically get encoded into the event name before the event is reported.

This allows a uniform interface to be used within the client app, whilst still converting

