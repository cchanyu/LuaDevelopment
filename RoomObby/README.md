### Project Name: Obby in the Room

### Description: 
``` 
This is an obstacle course game placed inside an enlarged bedroom.
The player has to overcome various obstacles to beat the game.
It'll consist of 250 stages throughout the room.
The level of difficulty will increase after every stage.
```

### Game Link:
The game will be live and updated at:
https://www.roblox.com/games/2856472117

### Game Pictures:
<a href = "Showcase/showcase-1.png"><img src = "Showcase/showcase-1.png">

### Programmed Components:
```
- Objects that has specific feature, such as moving parts, damaging parts.
- Communicates with dataService and will grab player's previously saved data or starts with default.
- Every time the new spawn point has been reached (boolean flag), connect function will update the data, thus saving user's progress.
- User is able to go back to the scompleted stages with a click of GUI button.
- Username and highest stage reached display on top of user's head.
- When user respawns, a script inside the starterPlayerPackage will teleport user to the latest spawn point.
```

### References:
```
- Server, Client data storage services and sync are automatically set up by Roblox.
- Many of functions can be found in: https://developer.roblox.com/en-us/api-reference
```