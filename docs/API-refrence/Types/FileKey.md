# FileKey
``` lua
type FileKey = string | number
```
## Description
A key that represents a file.

!!! note
    Unlike [Key](../Key), Files are stored as numbers or strings, so a key of '2' and 2 don't refrence the same file.