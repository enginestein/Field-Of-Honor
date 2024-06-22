# Field Of Honor

As it is not easy to port a roblox game to source easily, the code is messy but I have tried to import it. You can port it to Roblox Studio as well, but it will require some work.

## Getting Started

To build the place from scratch, use:

```bash
rojo build -o "Field Of Honor.rbxlx"
```

Next, open `Field Of Honor.rbxlx` in Roblox Studio and start the Rojo server:

```bash
rojo serve
```

## Porting To Roblox Studio

### Understanding Filesystem

- **BinData** contains terrain, mesh and some other binary data as **.rbxm** files. This can be directly dragged and dropped into Studio. This will go in **Workspace**.
- .rbxm file in **MaterialService** folder will go in MaterialService of Studio.
- Files which are in the root of **Scripts** folder go in workspace directly. There will be two folders, **Ambience** and **DeathScript**. Import **AmbienceManager.luau** to Studio and put the **AmbientSonds.rbxm** inside it.
- Same is with the **DeathScript** folder.
- .rbxm file in **Teams** folder goes in Teams folder of Roblox Studio.
- **WorkSpaceFolders.rbxm**, **WorkSpaceGoods.rbxm** and **WorkSpaceObj.rbxm** will be imported in the Workspace of Studio. **import.luau** is **NOT** a file which should be contained inside the game.

#### Files of **src** folder

- There is a **client** folder, its content wil go into **StarterPlayerScripts**.
- in **gui** folder, **KillNotification.rbxm** and **TeamSelection.rbxm** will go into **StarterGUI**.
- There is a **Menu** folder in **gui**, open it and import **menu.rbxm** to **StartGUI**.
- Everything in **server** folder goes into **ServerScriptService**
- Open **CapGuis** folder in **serverstorage**, import the **CapGuis.rbxm** into **ServerStorage** of Studio.
- Open **shared** folder and import **shared.rbxm** into **ReplicatedStorage**.
- Open **starterchar** and import **starterchar.rbxm** into **StarterCharacterScripts**.

Have a look at this JSON file to know where goes where:

```json
{
  "name": "Field Of Honor",
  "tree": {
    "$className": "DataModel",

    "ReplicatedStorage": {
      "Shared": {
        "$path": "src/shared"
      }
    },

    "ServerStorage": {
      "ServerStorage": {
        "$path": "src/serverstorage"
      }
    },

    "MaterialService": {
      "MaterialService": {
        "$path": "MaterialService"
      }
    },

    "Teams": {
      "Teams": {
        "$path": "teams"
      }
    },

    "ServerScriptService": {
      "Server": {
        "$path": "src/server"
      }
    },

    "StarterPlayer": {
      "StarterPlayerScripts": {
        "Client": {
          "$path": "src/client"
        }
      }
    },

    "Workspace": {
      "$properties": {
        "FilteringEnabled": true
      },
      "Baseplate": {
        "$className": "Part",
        "$properties": {
          "Anchored": true,
          "Color": [
            0.38823,
            0.37254,
            0.38823
          ],
          "Locked": true,
          "Position": [
            0,
            -10,
            0
          ],
          "Size": [
            512,
            20,
            512
          ]
        }
      }
    },
    "Lighting": {
      "$properties": {
        "Ambient": [
          0,
          0,
          0
        ],
        "Brightness": 2,
        "GlobalShadows": true,
        "Outlines": false,
        "Technology": "Voxel"
      }
    },
    "SoundService": {
      "$properties": {
        "RespectFilteringEnabled": true
      }
    }
  }
}
```



