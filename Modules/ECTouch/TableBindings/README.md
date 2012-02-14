This is an attempt to implement a sort of simplified bindings system for iOS tables.

It doesn't set out to attempt to recreate the full bindings system from MacOS X, just to simplify implementing common table tasks in iOS.

The basic idea is to:

- abstract a table to be a group of sections (by adding section controllers)
- allow mapping a property of a model object to a row in a section
- allow mapping an array of model objects to rows in a section
- use KVO to automatically update cells when the model objects are changed externally

The binding of model objects or arrays of model objects could be seen as roughly equivalent to using NSObjectController or NSArrayController.


Bindings
--------

Each row in a section is backed by a binding, which establishes an association between the row and the value of the property of a model object.

Because a binding maps the row to a property of an object,  rather than just to an object directly, we can use KVO to watch the property,
and can refresh the table when it changes.