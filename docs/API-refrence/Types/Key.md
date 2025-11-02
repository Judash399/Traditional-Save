# Key
``` lua
type Key = string | number
```
## Description
A key that represents a [Profile](../Profile) for a datastore.

!!! warning "Important!!"
    Note that all keys are eventually converted to strings when reading/writing to the DataStore! so a key of 2 and '2' would refrence the same [Profile](../Profile)!