This is an attempt to implement a sort of simplified bindings system for iOS tables.

It doesn't set out to attempt to recreate the full bindings system from MacOS X, just to simplify implementing common table tasks in iOS.

The basic idea is to:

- abstract a table to be a group of sections (by adding section controllers)
- allow mapping properties of a model object to be rows in a section
- allow mapping an array property of model objects to populate a section
- use KVO to automatically update cells when the model objects are changed externally
- defined some useful cell types

The binding of model objects or arrays of model objects could be seen as roughly equivalent to using NSObjectController or NSArrayController.


Bindings
--------

Each row in a section is backed by a binding, which establishes an association between the row and the value of a property of a bound object.

Because a binding maps the row to a property of an object, rather than just to an object directly, we can use KVO to watch the property,
and can refresh the table when it changes.

Bindings also carry meta data describing various properties of the cell/row. These can include what class to use for the cell, how to set it up, 
whether it has a disclosure view, and what class to use for that.


Section Plists
--------------

Most of the information for a section can be described in a dictionary. These can either be supplied at run time, or can be stored in a plist file. 
Various construction methods take an id for their properties. If you supply a dictionary it will be used directly. If you supply a string it will be
assumed to be the name of a plist file, from which a dictionary will be created.
