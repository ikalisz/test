# elix1rBase

##  How to use

### Client Side
```lua
exports['elix1rBase']:SendAlert('This is a test notification', 'info')
```
#### With Caption
```lua
exports['elix1rBase']:SendAlert({text = 'This is a test notification', caption = 'With a caption'}, 'info')
```

### Server Side
#### Send to everyone
```lua
TriggerClientEvent('torpak:notify', -1, 'This is a test notification', 'info')
```
With Caption
```lua
TriggerClientEvent('torpak:notify', -1, {text = 'This is a test notification', caption = 'With a caption'}, 'info')
```
#### Send to source
```lua
TriggerClientEvent('torpak:notify', source, 'This is a test notification', 'info')
```
With Caption
```lua
TriggerClientEvent('torpak:notify', source, {text = 'This is a test notification', caption = 'With a caption'}, 'info')
```



## Credits
Original notifications are taken from [qb-core](https://github.com/qbcore-framework/qb-core), I simply made them a standalone resource.
