# StoreConfig

```lua
type StoreConfig = {
    SeperateStudioData: boolean,
    UpdateInterval: number,
    SaveGetAttemptCount: number,
    IgnoreLockTime: number,
    TimestampUpdateInterval: number,
    LockingInStudio: boolean
}
```

## Description
StoreConfig is a configuration table that controls *TraditionalSave2* behavior. Below are the available settings and their default values:

### SeperateStudioData
**Default:** `true`

Controls whether TraditionalSave2 separates Studio and Live data. When enabled, save data in Studio and the Roblox client remain distinct. In a DataStore viewer, the scope will be marked as either "Studio" or "Live".

### UpdateInterval
**Default:** `60`

The frequency (in seconds) at which *TraditionalSave2* updates marked profiles. This prevents hitting DataStore limits from frequent saving.

### SaveGetAttemptCount
**Default:** `3`

The number of attempts *TraditionalSave2* will make to get or set DataStore values before assuming DataStoreService is unavailable.

### IgnoreLockTime
**Default:** `600`

The duration (in seconds) since the last DataStore update after which a locked profile's status will be ignored. This helps handle scenarios where server crashes prevent proper profile unlocking.

### TimestampUpdateInterval
**Default:** `180`

The interval (in seconds) for automatic DataStore saves to maintain recent timestamp information. These updates don't modify profile data. This is checked on the same cycle as the `UpdateInterval`!

### LockingInStudio
**Default:** `true`

Determines whether session locking is enabled in Studio. Recommended to be enabled to prevent issues with Test Session termination, which likely results in having to manually unlock the profile in a DataStore viewer.