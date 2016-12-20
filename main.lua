function setBlockSize()
    RESOLUTION = {
        SCREEN_SIZE = {x=love.graphics.getWidth(),y=love.graphics.getHeight()},
        BLOCK_SIZE = {X=50,Y=50}

    }
    BLOCKSIZE = RESOLUTION.BLOCK_SIZE
    BLOCKSIZE.Y = math.floor(RESOLUTION.SCREEN_SIZE.y/13)
    BLOCKSIZE.X = math.floor(((RESOLUTION.SCREEN_SIZE.x/13)*9.5)/13)

    Player.X = BLOCKSIZE.X*6
    Player.Y = BLOCKSIZE.Y*6
    Floor = {}
    for i = 1,13 do
        Plate = {}
        Plate.X = 0
        Plate.Y = BLOCKSIZE.Y*(i-1)
        table.insert(Floor, Plate)
        for v = 1,13 do
            Plate = {}
            Plate.X = BLOCKSIZE.X*(v-1)
            Plate.Y = BLOCKSIZE.Y*(i-1)
            table.insert(Floor, Plate)
        end
    end

    MovementDirections = {["up"]={x=0, y=(-BLOCKSIZE.Y)}, ["down"]={x=0, y=BLOCKSIZE.Y}, ["right"]={x=BLOCKSIZE.X, y=0}, ["left"]={x=(-BLOCKSIZE.X), y=0}}
end
function Add(type,x,y)
	local a={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y}
    table.insert(Workspace[type],a)
end

function love.load()

    KONAMI = {"w", "w", "s", "s", "a", "d", "a", "d", "l", "r"}
    KONAMI_INDEX = 1

    love.window.setMode(900,650)
    love.window.setTitle("Knut's Adventure")
    SPEED_FAST = 5;
    SPEED_SLOW = 10;
    IS_FULL_SCREEN = false
    MUTED = false;
    RESOLUTION = {
        SCREEN_SIZE = {x=love.graphics.getWidth(),y=love.graphics.getHeight()},
        BLOCK_SIZE = {X=50,Y=50}
    }
    BLOCKSIZE = RESOLUTION.BLOCK_SIZE
    BLOCKSIZE.Y = math.floor(RESOLUTION.SCREEN_SIZE.y/13)
    BLOCKSIZE.X = math.floor(((RESOLUTION.SCREEN_SIZE.x/13)*9.5)/13)

    KexLeft = 0
    Bonus = false;

    Texture = {
        Portal = love.graphics.newImage("/Texture/Objects/Portal.png"),
        Plate = love.graphics.newImage("/Texture/Objects/Ground.png"),
        Block = love.graphics.newImage("/Texture/Objects/Block.png"),
        Water = love.graphics.newImage("/Texture/Objects/Water.png"),
        Point = love.graphics.newImage("/Texture/Objects/Point.png"),
        KexDoor = love.graphics.newImage("/Texture/Objects/KexDoor.png"),
        Key = love.graphics.newImage("/Texture/Objects/Key.png"),
        PlayerR = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerR.png"),
        PlayerL = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerL.png"),   
        PlayerD = love.graphics.newImage("Texture/Character/CHRISTMAS/PlayerD.png"),
        PlayerU = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerU.png"),
        Player_WR = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WR.png"),
        Player_WL = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WL.png"),
        Player_WU = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WU.png"),
        Player_WD = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WD.png"),
        Lose = love.graphics.newImage("/Texture/SideBar/Lose.png"),
        Flippers = love.graphics.newImage("/Texture/Objects/Flipper.png"),
        LockR = love.graphics.newImage("/Texture/Objects/LockR.png"),
        LockB = love.graphics.newImage("/Texture/Objects/LockB.png"),
        LockG = love.graphics.newImage("/Texture/Objects/LockG.png"),
        LockY = love.graphics.newImage("/Texture/Objects/LockY.png"),
        Moveable = love.graphics.newImage("/Texture/Objects/Moveable.png"),
        Thief = love.graphics.newImage("/Texture/Objects/Thief.png"),
        Fire = love.graphics.newImage("/Texture/Objects/Fire.png"),
        Fireshoes = love.graphics.newImage("/Texture/Objects/FireShoes.png"),
        ConR = love.graphics.newImage("/Texture/Objects/ConveyorR.png"),
        ConL = love.graphics.newImage("/Texture/Objects/ConveyorL.png"),
        ConD = love.graphics.newImage("/Texture/Objects/ConveyorD.png"),
        ConU = love.graphics.newImage("/Texture/Objects/ConveyorU.png"),
        ButtonBlock = love.graphics.newImage("/Texture/Objects/Button.png"),
        Teleporter = love.graphics.newImage("/Texture/Objects/Teleporter.png"),
        HoverBoots = love.graphics.newImage("/Texture/Objects/HoverBoots.png"),
        Bomb = love.graphics.newImage("/Texture/Objects/Bomb.png"),
        BounceBall = love.graphics.newImage("/Texture/Objects/BounceBall.png"),
        Hint = love.graphics.newImage("/Texture/Objects/Hint.png"),
        Ice = love.graphics.newImage("/Texture/Objects/Ice.png"),
        DDosKid = love.graphics.newImage("/Texture/Objects/DDOSKID.png"),
        IceSkates = love.graphics.newImage("/Texture/Objects/IceSkates.png"),
        TFButton = love.graphics.newImage("/Texture/Objects/TFButton.png"),
        TFBlock = love.graphics.newImage("/Texture/Objects/TFBlock.png"),
    }
    Sound = {
        Splash = love.audio.newSource("/Sound/Splash.wav","static"),
        Win = love.audio.newSource("/Sound/Win.wav","static"),
        Death =love.audio.newSource("/Sound/Death.wav","static"),
        Get = love.audio.newSource("/Sound/get.wav","static"),
        Button = love.audio.newSource("/Sound/Button.wav","static"),
        Wall = love.audio.newSource("/Sound/wall.wav","static"),
        Unlock = love.audio.newSource("/Sound/door.wav","static"),
        Bummer = love.audio.newSource("/Sound/Bummer.wav","static"),
        Thief = love.audio.newSource("Sound/Thief.wav","static"),
        Burn = love.audio.newSource("Sound/burn.wav","static"),
        get1 = love.audio.newSource("Sound/get1.wav","static"),
        Locked = love.audio.newSource("Sound/Locked.mp3","static")
    }
    Music = {
        Chip01 = love.audio.newSource("/Soundtracks/Chip01.mp3"),
        Chip02 = love.audio.newSource("/Soundtracks/Chip02.mp3"),
        Chip03 = love.audio.newSource("/Soundtracks/Chip03.mp3"),
    }
    Player = {
        X = BLOCKSIZE.X*6,
        Y = BLOCKSIZE.Y*6,
        Image = Texture.PlayerR,
        Points = 0,
        Dead = false,
        cooldown = 0,
        Wait = SPEED_SLOW,
        Sliding = false,
        Inventory = {
            Flippers = false,
            RedKey = false,
            BlueKey = false,
            GreenKey = false,
            YellowKey = false,
            FireShoes = false,
            HoverBoots = false,
            IceSkates = false,
        },
        Hint = false,
        moveRight = function()
        	Player.Image = Texture.PlayerR
            gayloop("right")
            check("right")
        end,
        moveLeft = function()
        	Player.Image = Texture.PlayerL
            gayloop("left")
            check("left")
        end,
        moveUp = function()
        	Player.Image = Texture.PlayerU
            gayloop("up")
            check("up")
        end,
        moveDown = function()
        	Player.Image = Texture.PlayerD
            gayloop("down")
            check("down")
        end,

    }
    Workspace = {
        ["Block"] = {},
        ["Water"] = {},
        ["Portal"] = {},
        ["Point"] = {},
        ["KexDoor"] = {},
        ["Flippers"] = {},
        ["RedKey"] = {},
        ["GreenKey"] = {},
        ["BlueKey"] = {},
        ["YellowKey"] = {},
        ["LockR"] = {},
        ["LockG"] = {},
        ["LockB"] = {},
        ["LockY"] = {},
        ["Moveable"] = {},
        ["Thief"] = {},
        ["Fire"] = {},
        ["Fireshoes"] = {},
        ["ConR"] = {},
        ["ConL"] = {},
        ["ConD"] = {},
        ["ConU"] = {},
        ["ButtonBlock"] = {},
        ["Teleporter"] = {},
        ["HoverBoots"] = {},
        ["Dirt"] = {},
        ["Bomb"] = {},
        ["BounceBall"] = {},
        ["Hint"] = {},
        ["DDosKid"] = {},
        ["Ice"] = {},
        ["IceSkates"]= {},
        ["TFButton"] = {},
        ["TFBlock"] = {},
    }
    Special = {
		conveyor = 0,
		Iceway = "Down",
		cooldownICE = 10;
		TF_BOOL = false;
		BounceCooldown = 0;
	}
	StageInfo = {
		LevelIndex = {"one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen"},
		LevelsInfo = {
			one={hint="Hint: Collect all tiger biscuits to\nget past the iron door",NAME="LESSON 1"},
			two={hint="",NAME="LESSON 2"},
			three={hint="Hint: Use keys to open doors. Green\nkeys does never get destroyed when\nused",NAME="LESSON 3"},
			four={hint="Hint: Plunger boots for force floors.\nFire boots for fire. Flippers for water.",NAME="LESSON 4"},
			five={hint="",NAME="LESSON 5"},
			six={hint="Hint: The thief takes your tools. New\nwalls can appear behind you when \nstepped on grey buttons.",NAME = "LESSON 5"},
			seven={NAME="LESSON 6"},
			eight={hint="Hint: Push blocks into water to make\ndirt.",NAME="LESSON 7"},
			nine={hint="",NAME="Use your brain on this one!"},
			ten={hint="dont you agree that this is a A-MAZE-ing\nlevel?",NAME="BRUSHFIRE"},
			eleven={hint="Hint: Press \"R\" on the keyboard to \nrestart the level :-)",NAME="TOO MUCH DOTS!"},
			twelve={hint="Looks like you will have to build\na bridge.",NAME="Castle moat"},
			thirteen={NAME="Elementary"},
			fourteen={NAME="FORCED ENTRY"},
			fifteen={NAME="Seeing stars",hint="lets put your moving blocks to the\ntest."},

		}
	}
    BeatStage = false;
    index = {"Chip01","Chip02"}--,"Chip03","Chip04","Chip05"
    MusicIndex = index[love.math.random(#index)]
    Music[MusicIndex]:setVolume(0.5) --0.5
    CurrentStage = 1
    
    function ResetStage(Lnext)
    	Texture.PlayerR = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerR.png");
        Texture.PlayerL = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerL.png");
        Texture.PlayerD = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerD.png");
       	Texture.PlayerU = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerU.png");
        Texture.Player_WD = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WD.png");
        Texture.Player_WU = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WU.png");
   	    Texture.Player_WR = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WR.png");
        Texture.Player_WL = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WL.png");
    	local bonus = false;
        for i = 1,10 do
            for _,v in pairs(Workspace)do
                for t,i in pairs(v)do
                    table.remove(v,t)
                end
            end
        end
        Player.Points = 0
        Player.X = BLOCKSIZE.X*6
        Player.Y = BLOCKSIZE.Y*6
        Player.image = Texture.PlayerR
        for i,_ in pairs(Player.Inventory)do
            Player.Inventory[i] = false;
        end
        local File = {}
        if Lnext then
        	CurrentStage = CurrentStage + 1
        	Music["Chip03"]:stop()
    		Texture.PlayerR = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerR.png");
        	Texture.PlayerL = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerL.png");
       	    Texture.PlayerD = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerD.png");
       	    Texture.PlayerU = love.graphics.newImage("/Texture/Character/CHRISTMAS/PlayerU.png");
        	Texture.Player_WD = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WD.png");
            Texture.Player_WU = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WU.png");
       	    Texture.Player_WR = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WR.png");
       	    Texture.Player_WL = love.graphics.newImage("/Texture/Character/CHRISTMAS/Player_WL.png");
       	    if CurrentStage > 6 then
       	    	local rad = love.math.random(1,1)
            	if rad == 1 then
            		CurrentStage = CurrentStage -1 
            		Music[MusicIndex]:stop()
            		Bonus=true;
            		bonus = true;
            		for line in love.filesystem.lines("/Levels/Bonus1")do
        	    	    table.insert(File,line)
        	    	end
        	    	Texture.PlayerL = love.graphics.newImage("/Texture/Character/BONUS/PlayerR.png");
        	    	Texture.PlayerR = love.graphics.newImage("/Texture/Character/BONUS/PlayerL.png");
        	    	Texture.PlayerD = love.graphics.newImage("/Texture/Character/BONUS/PlayerD.png");
        	    	Texture.PlayerU = love.graphics.newImage("/Texture/Character/BONUS/PlayerU.png");
        	    	Texture.Player_WD = love.graphics.newImage("/Texture/Character/BONUS/Player_WD.png");
        	    	Texture.Player_WU = love.graphics.newImage("/Texture/Character/BONUS/Player_WU.png");
        	    	Texture.Player_WR = love.graphics.newImage("/Texture/Character/BONUS/Player_WR.png");
        	    	Texture.Player_WL = love.graphics.newImage("/Texture/Character/BONUS/Player_WL.png");
        	   		Player.Image = Texture.PlayerR
            	end
       	    end
        end
        if bonus == false then 
        	Bonus = false;
        	if CurrentStage == "test"then
        	    for line in love.filesystem.lines("/Levels/TestStage")do
        	        table.insert(File,line)
        	    end
        	else
        	    for line in love.filesystem.lines("/Levels/Stage"..CurrentStage)do
        	        table.insert(File,line)
        	    end
        	    love.window.setTitle("Knut's Adventure // ".. StageInfo.LevelsInfo[StageInfo.LevelIndex[CurrentStage]].NAME)
        	end
        end
        for s,v in pairs(File)do
       	    local line = s
       	    for i = 0,#v,1 do
       	        Text = string.sub(v,i,i)
       	        Place(Text,i,s)
       	    end
        end
        KexLeft = #Workspace["Point"]
        TimeLeft = 80
    end
    setBlockSize()
    function gayloop(k)
        for i,v in pairs(Workspace)do
            if i == "Water"then
                for _,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then
                        if Player.Inventory.Flippers then
                            Sound.Splash:play()
                            if k=="right"then 
                                Player.Image=Texture.Player_WR 
                            elseif k=="left"then 
                                Player.Image=Texture.Player_WL 
                            elseif k=="up"then
                                Player.Image=Texture.Player_WU
                            elseif k=="down"then
                                Player.Image=Texture.Player_WD
                            end
                        else
                            Sound.Splash:stop()
                            Sound.Splash:play()
                            Player.Dead = true
                        end
                    end
                end
            end
            if i == "Block"then
                for _,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then Sound.Wall:play()
                    	for _,v in pairs(Workspace["Ice"])do
                    		if v.X == Player.X and v.Y == Player.Y then 
                    			local opposite = {["up"]="down",["down"]="up",["left"]="right",["right"]="left"}
                    			Special.Iceway = opposite[Special.Iceway]
                    		end
                    	end
                    	return 
                    end
                end
            end
            if i == "KexDoor" then
                for _,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X==Player.X+MovementDirections[k].x)and(KexLeft ~= 0) then Sound.Locked:play()return end
                end
            end
            if i == "LockR"then
                for r,f in pairs(v)do
                    if (f.Y == Player.Y+MovementDirections[k].y)and(f.X==Player.X+MovementDirections[k].x)then
                        if Player.Inventory.RedKey then
                            table.remove(v,r)
                            Player.Inventory.RedKey=false;
                            Sound.Unlock:play()
                        else Sound.Locked:play()return end
                    end
                end
            end
            if i == "LockB"then
                for r,f in pairs(v)do
                    if (f.Y == Player.Y+MovementDirections[k].y)and(f.X==Player.X+MovementDirections[k].x)then
                        if Player.Inventory.BlueKey then
                            table.remove(v,r)
                            Player.Inventory.BlueKey=false
                            Sound.Unlock:stop()
                            Sound.Unlock:play()
                        else Sound.Locked:play()return end
                    end
                end
            end
            if i == "LockG"then
                for r,f in pairs(v)do
                    if (f.Y==Player.Y+MovementDirections[k].y)and(f.X==Player.X+MovementDirections[k].x)then
                        if Player.Inventory.GreenKey then
                            table.remove(v,r)
                            Sound.Unlock:stop()
                            Sound.Unlock:play()
                        else Sound.Locked:play()return end
                    end
                end
            end
            if i == "LockY"then
                for r,f in pairs(v)do
                    if (f.Y==Player.Y+MovementDirections[k].y)and(f.X==Player.X+MovementDirections[k].x)then
                        if Player.Inventory.YellowKey then
                            table.remove(v,r)
                            Player.Inventory.YellowKey=false
                            Sound.Unlock:stop()
                            Sound.Unlock:play()
                        else Sound.Locked:play()return end
                    end
                end
            end
            if i == "Moveable"then
                for z,m in pairs(v)do
                    if m.X==Player.X+MovementDirections[k].x and m.Y==Player.Y+MovementDirections[k].y then
                    	local wx,wy,PlaceDirt = 0,0,false
                        for n,f in pairs(Workspace)do
                            for w,c in pairs(f)do
                                if c.X == m.X+MovementDirections[k].x and c.Y == m.Y+MovementDirections[k].y then
                                    if n=="Water" or n=="Bomb"then
                                    	table.remove(v,z)
                                        table.remove(f,w)
                                        if n=="Water"then
                                        	wx,wy,PlaceDirt=c.X,c.Y,true;
                                            Sound.Splash:play()
                                        else
                                            Sound.Burn:play()
                                        end
                                    elseif n=="Hint" or n=="ConD" or n=="ConL" or n=="ConR" or n=="ConU"then
                                    elseif n=="TFBlock" and c.BOOL==false then
                                    else 
                                    	Sound.Wall:play()return
                                    end
                                end
                            end
                        end
                        m.X = m.X+MovementDirections[k].x
                        m.Y = m.Y+MovementDirections[k].y
                        if PlaceDirt then
                        	local c = {X=wx,Y=wy}
                        	table.insert(Workspace["Dirt"],c)
                        end
                    end
                end
            end
            if i=="Thief"then
                for _,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then 
                        for i,_ in pairs(Player.Inventory)do
                            Player.Inventory[i] = false;
                        end
                        Sound.Thief:stop()
                        Sound.Thief:play()
                    end
                end
            end
            if i == "Fire"then
                for _,f in pairs(v)do
                    if (f.Y==Player.Y+MovementDirections[k].y)and(f.X==Player.X+MovementDirections[k].x)then
                        if Player.Inventory.FireShoes then else
                            Sound.Burn:stop()
                            Sound.Burn:play()
                            Player.Dead = true
                        end
                    end
                end
            end
            if i == "Bomb"then
                for _,f in pairs(v)do
                    if f.X==Player.X+MovementDirections[k].x and f.Y==Player.Y+MovementDirections[k].y then
                        Sound.Burn:play()
                        Player.Dead=true;
                    end
                end
            end
            if i == "DDosKid"then
                for _,f in pairs(v)do
                    if f.X==Player.X+MovementDirections[k].x and f.Y==Player.Y+MovementDirections[k].y then
                        error("Git dddosed kiddo! yo will nao huve to start uver again HUEUEUEUEUe \n\n  xXxDdosMasterKidzxXx was here")
                    end
                end
            end
            if i == "TFButton"then
            	for _,f in pairs(v)do
                    if f.X==Player.X+MovementDirections[k].x and f.Y==Player.Y+MovementDirections[k].y then
						if Special.TF_BOOL then
							Special.TF_BOOL = false;
						else
							Special.TF_BOOL = true;
						end
						Sound.Button:stop()
						Sound.Button:play()
						for _,v in pairs(Workspace["TFBlock"])do
							if v.BOOL then
								v.BOOL = false;
							else
								v.BOOL = true;
							end
						end
                    end
                end
            end
            if i == "TFBlock"then
                for _,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then 
                    	if v.BOOL then
                    		Sound.Wall:play()
                    		for _,v in pairs(Workspace["Ice"])do
                    			if v.X == Player.X and v.Y == Player.Y then 
                    				local opposite = {["up"]="down",["down"]="up",["left"]="right",["right"]="left"}
                    				Special.Iceway = opposite[Special.Iceway]
                    			end
                    		end
                    		return 
                   		end
                    end
                end
            end
        end
        for _,v in pairs(Workspace)do
            for _,i in pairs(v)do
                i.X = i.X + (-MovementDirections[k].x)
                i.Y = i.Y + (-MovementDirections[k].y)
            end
        end
    end
    function check(k)
        for e,f in pairs(Workspace)do
            if e == "Portal"and #f>=1 then
                for _,v in pairs(f)do
                    if v.X==Player.X and v.Y==Player.Y then
                        Sound.Win:play()
                        BeatStage = true
                        Bonus = false;
                    end
                end
            end
            if e=="Point"and #f>=1 then
                for i,v in pairs(f)do
                    if (v.X==Player.X)and(v.Y==Player.Y)then
                        KexLeft = KexLeft - 1
                        if KexLeft == 0 and #Workspace["KexDoor"] > 0 then 
                            for i = 1,#Workspace["KexDoor"]do
                                for i,_ in pairs(Workspace["KexDoor"])do
                                    table.remove(Workspace["KexDoor"],i)
                                end
                            end
                            Sound.Button:play()
                        else
                            Sound.get1:stop()
                            Sound.get1:play()
                        end
                        table.remove(Workspace["Point"],i)
                    end
                end
            end
            if e=="Flippers"and#f>=1 then
                for i,v in pairs(f)do
                    if v.X==Player.X and v.Y==Player.Y then
                        Player.Inventory.Flippers=true
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="RedKey"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.RedKey=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="GreenKey"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.GreenKey=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="BlueKey"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.BlueKey=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="YellowKey"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.YellowKey=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="Fireshoes"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.FireShoes=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="Water"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        if k=="right"then 
                            Player.Image=Texture.Player_WR 
                        elseif k=="left"then 
                            Player.Image=Texture.Player_WL 
                        elseif k=="up"then
                            Player.Image=Texture.Player_WU
                        elseif k=="down"then
                            Player.Image=Texture.Player_WD
                        end
                    end
                end
            end
            if e=="HoverBoots"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.HoverBoots=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e == "ButtonBlock" then
                for i,z in pairs(f)do
                    if z.Y==Player.Y-MovementDirections[k].y and z.X==Player.X-MovementDirections[k].x then
                        local c={};
                        c.Y=z.Y
                        c.X=z.X
                        table.insert(Workspace["Block"],c)
                        table.remove(f,i)
                    end
                end
            end
            if e=="Dirt" then
                for i,z in pairs(f)do
                    if z.Y == Player.Y and z.X == Player.X then
                        table.remove(f,i)
                    end
                end
            end
            if e=="Hint"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Hint = true;
                    else
                        Player.Hint = false;
                    end
                end
            end
            if e=="IceSkates"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.IceSkates=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
        end
    end
    function Place(t,x,y)
        if t=="#"then
            Add("Block",x,y)
        elseif t=="o"then
            Add("Portal",x,y)
        elseif t=="W"then
            Add("Flippers",x,y)
        elseif t=="w"then
            Add("Water",x,y)
        elseif t=="k"then
            Add("Point",x,y)
        elseif t=="h"then
            Add("KexDoor",x,y)
        elseif t=="R"then
            Add("RedKey",x,y)
        elseif t=="B"then
            Add("BlueKey",x,y)
        elseif t=="G"then
            Add("GreenKey",x,y)
        elseif t=="Y"then
            Add("YellowKey",x,y)
        elseif t=="r"then
            Add("LockR",x,y)
        elseif t=="b"then
            Add("LockB",x,y)
        elseif t=="g"then
            Add("LockG",x,y)
        elseif t=="y"then
            Add("LockY",x,y)
        elseif t=="m"then
            Add("Moveable",x,y)
        elseif t=="t"then
            Add("Thief",x,y)
        elseif t=="f"then
            Add("Fire",x,y)
        elseif t=="F"then
            Add("Fireshoes",x,y)
        elseif t=="v"then
            Add("ConD",x,y)
        elseif t=="^"then
            Add("ConU",x,y)
        elseif t=="<"then
            Add("ConL",x,y)
        elseif t==">"then
            Add("ConR",x,y)
        elseif t=="-"then
            Add("ButtonBlock",x,y)
        elseif t=="V"then
            Add("HoverBoots",x,y)
        elseif t=="d"then
            Add("Dirt",x,y)
        elseif t=="Q"then
            Add("Bomb",x,y)
        elseif t=="O"then
        	local c = {X = x*BLOCKSIZE.X,Y = y*BLOCKSIZE.Y,RIGHT=false}
            table.insert(Workspace["BounceBall"],c)
        elseif t=="H"then
            Add("Hint",x,y)
        elseif t=="D"then
            Add("DDosKid",x,y)
        elseif t=="i"then
            Add("Ice",x,y)
        elseif t=="I"then
            Add("IceSkates",x,y)
        elseif t=="*"then
            Add("TFButton",x,y)
        elseif t=="E"then
            local a = {X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,BOOL = true}
            table.insert(Workspace["TFBlock"],a)
        elseif t=="e"then
            local a = {X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,BOOL = false}
            table.insert(Workspace["TFBlock"],a)
        elseif t==","then
            for _,v in pairs(Workspace)do
                for _,f in pairs(v)do
                    f.X = f.X - BLOCKSIZE.X
                end
            end
        elseif t=="."then
            for _,v in pairs(Workspace)do
                for _,f in pairs(v)do
                    f.Y = f.Y - BLOCKSIZE.Y
                end
            end
        end
    end
    Music[MusicIndex]:play()
    ResetStage()
end


function love.keypressed(key)
    if Player.Dead then
        for i = 1,10 do
            for _,v in pairs(Workspace)do
                for t,i in pairs(v)do
                    table.remove(v,t)
                end
            end
        end
        ResetStage()
        Player.Dead = false
    end
    if BeatStage then 
        BeatStage = false
        ResetStage(true)
        Music[MusicIndex]:stop()
        MusicIndex = index[love.math.random(#index)]
        Music[MusicIndex]:setVolume(0.4) --0.5
        if MUTED then
            Music[MusicIndex]:setVolume(0)
        end

        Music[MusicIndex]:play()
    end
    if key =="m"then
    	if MUTED then
    		Music[MusicIndex]:setVolume(0.5)
    		MUTED = false;
    	else
    		Music[MusicIndex]:setVolume(0)
    		MUTED = true;
    	end
    end
    if key=="r"then
    	Music["Chip03"]:stop()
        ResetStage()
        Player.Image = Texture.PlayerR
    end
    if key=="lshift"then
        Player.Wait = SPEED_FAST
    end
    if key=="f"then
        IS_FULL_SCREEN = not IS_FULL_SCREEN
        success = love.window.setFullscreen(IS_FULL_SCREEN, "desktop")
        setBlockSize()
        ResetStage()
    end
    if KONAMI_INDEX == #KONAMI then
        CurrentStage = CurrentStage + 1
        ResetStage()
        KONAMI_INDEX = 1
    end
    if key == KONAMI[KONAMI_INDEX] then
        KONAMI_INDEX = KONAMI_INDEX + 1
    else
        KONAMI_INDEX = 1
    end
end

function love.keyreleased(key)
    if key=="lshift"then
        Player.Wait = SPEED_SLOW
    end
end

function love.update()
	if Bonus then
		Music[MusicIndex]:stop()
		Music["Chip03"]:setVolume(0.5)
		Music["Chip03"]:play()
	else
		Music[MusicIndex]:play()
	end
    if Player.Dead then Player.Image = Texture.PlayerR;Music["Chip03"]:stop()Bonus=false; return end
    if BeatStage then if Bonus then Bonus = false;end return end
    if #Workspace["BounceBall"]>=1 then
        if Special.BounceCooldown >=20 then
            for _,v in pairs(Workspace["BounceBall"])do
                for _,f in pairs(Workspace)do
                    for _,c in pairs(f)do
                    	if v.RIGHT then
                    		if c.X == v.X + BLOCKSIZE.X and c.Y == v.Y then
                                v.RIGHT = false;
                    		end
                    		v.X = v.X + BLOCKSIZE.X
                    	else
                    		if c.X == v.X - BLOCKSIZE.X and c.Y == v.Y then
                                v.RIGHT = true;
                    		end
                    		v.X = v.X - BLOCKSIZE.X
                    	end
                    end
                end
                break
            end
        end
        Special.BounceCooldown = Special.BounceCooldown + 1
    end
    if #Workspace["ConD"]>=1 or#Workspace["ConL"]>=1 or#Workspace["ConR"]>=1 or#Workspace["ConU"]>=1 then
        if Special.conveyor == 5 then
            Special.conveyor = 0
            for e,f in pairs(Workspace)do
                if Player.Inventory.HoverBoots then break end
                if e == "ConD"then
                	local BOOL=true
                    for _,f in pairs(f)do
                    	if BOOL then
                    		for _,m in pairs(Workspace["Moveable"])do
                    		   	if m.X == f.X and m.Y == f.Y then
                    		 		m.Y = m.Y + BLOCKSIZE.Y
                    		 		BOOL=false;
                    		   		break
                    		    end
                    		end
                    	end
                        if (f.Y==Player.Y)and(f.X==Player.X)then
                            Player.moveDown();
                            Special.Iceway = "down"
                            break
                        end
                    end
                end
                if e == "ConL"then
                	local BOOL=true
                    for _,f in pairs(f)do
                    	if BOOL then
                    		for _,m in pairs(Workspace["Moveable"])do
                    		   	if m.X == f.X and m.Y == f.Y then
                    		 		m.X = m.X - BLOCKSIZE.X
                    		 		BOOL=false;
                    		   		break
                    		    end
                    		end
                    	end
                        if (f.Y==Player.Y)and(f.X==Player.X)then
                            Player.moveLeft();
                            Special.Iceway = "left"
                            break
                        end
                    end
                end
                if e == "ConR"then
                	local BOOL = true;
                    for _,f in pairs(f)do
                    	if BOOL then
                    		for _,m in pairs(Workspace["Moveable"])do
                    		   	if m.X == f.X and m.Y == f.Y then
                    		 		m.X = m.X + BLOCKSIZE.X
                    		 		BOOL=false;
                    		   		break
                    		    end
                    		end
                    	end
                        if (f.Y==Player.Y)and(f.X==Player.X)then
                            Player.moveRight();
                            Special.Iceway = "right"
                            break
                        end
                    end
                end
                if e == "ConU"then
                	local BOOL = true;
                    for _,f in pairs(f)do
                    	if BOOL then
                    		for _,m in pairs(Workspace["Moveable"])do
                    		   	if m.X == f.X and m.Y == f.Y then
                    		 		m.Y = m.Y - BLOCKSIZE.Y
                    		 		BOOL=false;
                    		   		break
                    		    end
                    		end
                    	end
                        if (f.Y==Player.Y)and(f.X==Player.X)then
                            Player.moveUp();
                            Special.Iceway = "up"
                            break
                        end
                    end
                end
            end
        end
        Special.conveyor = Special.conveyor + 1
    end
    if #Workspace["Ice"]>=1 then
    	if Player.Inventory.IceSkates == false then
			Special.cooldownICE = Special.cooldownICE - 1
			if Special.cooldownICE <= 0 then
				Special.cooldownICE = 4;
				for _,v in pairs(Workspace["Ice"])do
					if v.X == Player.X and v.Y == Player.Y then
						Player["move"..string.upper(string.sub(Special.Iceway,1,1))..string.sub(Special.Iceway,2)]()
						Player.Sliding = true; break
					else
						Player.Sliding = false;
					end
				end
			end
		end
	end
    Player.cooldown = Player.cooldown + 1
    if Player.Sliding then return end
    if love.keyboard.isDown("up")then
        if Player.cooldown >= Player.Wait then
            Player.cooldown = 0
            Player.moveUp();
            Special.Iceway = "up";
        end
    elseif love.keyboard.isDown("down")then
        if Player.cooldown >= Player.Wait then
            Player.cooldown = 0
            Player.moveDown();
            Special.Iceway = "down";
        end
    elseif love.keyboard.isDown("right")then
        if Player.cooldown >= Player.Wait then
            Player.cooldown = 0
            Player.moveRight();
            Special.Iceway = "right";
        end
    elseif love.keyboard.isDown("left")then
        if Player.cooldown >= Player.Wait then
            Player.cooldown = 0
            Player.moveLeft();
            Special.Iceway = "left";
        end
    end
    if Player.image == Texture.Splash then Player.image = Texture.PlayerL end
end

function love.draw()
    love.graphics.setColor(255,255,255)
    for _, v in pairs(Floor)do love.graphics.draw(Texture.Plate,v.X,v.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)end
    for i,v in pairs(Workspace)do
        for c,f in pairs(v)do
            if i == "YellowKey"then
                love.graphics.setColor(255,200,0)
                love.graphics.draw(Texture.Key,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "GreenKey"then
                love.graphics.setColor(0,255,0)
                love.graphics.draw(Texture.Key,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "BlueKey"then
                love.graphics.setColor(0,0,255)
                love.graphics.draw(Texture.Key,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "RedKey"then
                love.graphics.setColor(255,0,0)
                love.graphics.draw(Texture.Key,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "Dirt"then
                love.graphics.setColor(102,51,0)
                love.graphics.rectangle("fill",f.X,f.Y,BLOCKSIZE.X,BLOCKSIZE.Y)
            else
                love.graphics.setColor(255,255,255)
                love.graphics.draw(Texture[i],f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            end
        end
    end
    for _,f in pairs(Workspace["TFBlock"])do
    	if f.BOOL then
       		love.graphics.draw(Texture.Block,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
       		love.graphics.draw(Texture.TFBlock,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
       	else
      		love.graphics.draw(Texture.TFBlock,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
        end
    end
    love.graphics.setColor(255,255,255)
    love.graphics.draw(Player.Image,Player.X,Player.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    love.graphics.setColor(100,100,100)
    love.graphics.rectangle("fill",BLOCKSIZE.X*13,0,BLOCKSIZE.X*5,RESOLUTION.SCREEN_SIZE.y)
    love.graphics.setColor(50,50,50)
    love.graphics.rectangle("line",BLOCKSIZE.X*13,0,BLOCKSIZE.X*5,RESOLUTION.SCREEN_SIZE.y)
    love.graphics.setColor(255,255,255)

    if CurrentStage == "test"then
        love.graphics.print("Level: TEST",BLOCKSIZE.X*13.1,BLOCKSIZE.Y*0.1,0,1,1)
        love.graphics.print("\nBLOCK X: "..BLOCKSIZE.X.."\nBLOCK Y: "..BLOCKSIZE.Y.."\nPlayerPosX: "..Player.X.."\nPlayerPosY: "..Player.Y.."\nBlockPos X,Y "..Workspace["Block"][1].X.."\n"..Workspace["Block"][1].Y,BLOCKSIZE.X*13.1,BLOCKSIZE.Y*0.1,0,1,1)
    else
        love.graphics.print("Level: ".. StageInfo.LevelIndex[CurrentStage],BLOCKSIZE.X*13.1,BLOCKSIZE.Y*0.1)
        love.graphics.print("\nTiger biscuits left: "..KexLeft ,BLOCKSIZE.X*13.1,BLOCKSIZE.Y*0.1)
    end
    love.graphics.setColor(200,200,200)
    love.graphics.rectangle("fill",BLOCKSIZE.X*13,BLOCKSIZE.Y*8.5,BLOCKSIZE.X*5,BLOCKSIZE.Y*2)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",BLOCKSIZE.X*13,BLOCKSIZE.Y*8.48,BLOCKSIZE.X*5,BLOCKSIZE.Y*2)
    love.graphics.rectangle("line",BLOCKSIZE.X*13,BLOCKSIZE.Y*8.48,BLOCKSIZE.X*5,BLOCKSIZE.Y*2)
    love.graphics.rectangle("line",BLOCKSIZE.X*14,BLOCKSIZE.Y*8.48,BLOCKSIZE.X*3,BLOCKSIZE.Y*2)
    love.graphics.rectangle("line",BLOCKSIZE.X*15,BLOCKSIZE.Y*8.48,BLOCKSIZE.X*1,BLOCKSIZE.Y*2)
    love.graphics.rectangle("line",BLOCKSIZE.X*13,BLOCKSIZE.Y*9.5,BLOCKSIZE.X*6,BLOCKSIZE.Y*0.01)

    if Player.Inventory.Flippers then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(Texture.Flippers,BLOCKSIZE.X*13,BLOCKSIZE.Y*8.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.FireShoes then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(Texture.Fireshoes,BLOCKSIZE.X*14,BLOCKSIZE.Y*8.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.RedKey then
        love.graphics.setColor(255,0,0)
        love.graphics.draw(Texture.Key,BLOCKSIZE.X*13,BLOCKSIZE.Y*9.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.BlueKey then
        love.graphics.setColor(0,0,255)
        love.graphics.draw(Texture.Key,BLOCKSIZE.X*14,BLOCKSIZE.Y*9.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.GreenKey then
        love.graphics.setColor(0,255,0)
        love.graphics.draw(Texture.Key,BLOCKSIZE.X*15,BLOCKSIZE.Y*9.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.YellowKey then
        love.graphics.setColor(255,200,0)
        love.graphics.draw(Texture.Key,BLOCKSIZE.X*16,BLOCKSIZE.Y*9.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.HoverBoots then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(Texture.HoverBoots,BLOCKSIZE.X*15,BLOCKSIZE.Y*8.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
     if Player.Inventory.IceSkates then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(Texture.IceSkates,BLOCKSIZE.X*16,BLOCKSIZE.Y*8.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    --[[
        love.graphics.setColor(80,78,78)
        love.graphics.rectangle("fill",650,200,250,250)
    --]]
    if Player.Hint then
        love.graphics.setColor(255,255,255)
        love.graphics.print(StageInfo.LevelsInfo[StageInfo.LevelIndex[CurrentStage]].hint,BLOCKSIZE.X*13.1,BLOCKSIZE.Y*4)
    end
    if BeatStage then
        love.graphics.setColor(150,150,150)
        love.graphics.rectangle("fill",100,150,450,350)
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line",100,150,450,350)
        love.graphics.draw(love.graphics.newImage("/Texture/SideBar/WinScreen.png"),100,150)
    end
    if Player.Dead then
        love.graphics.setColor(150,150,150)
        love.graphics.rectangle("fill",100,150,450,350)
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line",100,150,450,350)
        love.graphics.draw(Texture.Lose,100,150)
    end
end