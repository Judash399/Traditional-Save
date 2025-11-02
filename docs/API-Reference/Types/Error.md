# Error
```lua
type Error = {
	Error: true, --Used to check if there was an error.
	Reason: string, --Why this error occured.
}
```
## Description
Represents an error object returned by certain functions. Used to determine if the result was unsuccessful, and Reason provides the cause.