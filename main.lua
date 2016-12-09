function love.load()
	love.window.setMode(900,650)
	love.window.setTitle(" ")
	Stage = {LevelName = ""}
	KexLeft = 0

	Texture = {
		Portal = love.graphics.newImage("/Texture/Objects/Portal.png"),
		Plate = love.graphics.newImage("/Texture/Objects/Ground.png"),
		Block = love.graphics.newImage("/Texture/Objects/Block.png"),
		Water = love.graphics.newImage("/Texture/Objects/Water.png"),
		Point = love.graphics.newImage("/Texture/Objects/Point.png"),
		KexDoor = love.graphics.newImage("/Texture/Objects/KexDoor.png"),
		Inv = love.graphics.newImage("/Texture/SideBar/Inventory.png"),
		Key = love.graphics.newImage("/Texture/Objects/Key.png"),
		PlayerR = love.graphics.newImage("/Texture/Character/PlayerR.png"),
		PlayerL = love.graphics.newImage("/Texture/Character/PlayerL.png"),	
		PlayerD = love.graphics.newImage("Texture/Character/PlayerD.png"),
		PlayerU = love.graphics.newImage("/Texture/Character/PlayerU.png"),
		Player_WR = love.graphics.newImage("/Texture/Character/Player_WR.png"),
		Player_WL = love.graphics.newImage("/Texture/Character/Player_WL.png"),
		Player_WU = love.graphics.newImage("/Texture/Character/Player_WU.png"),
		Player_WD = love.graphics.newImage("/Texture/Character/Player_WD.png"),
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
	}
	Music = {
		Chip01 = love.audio.newSource("/Soundtracks/Chip01.mp3"),
		Chip02 = love.audio.newSource("/Soundtracks/Chip02.mp3"),
		Chip03 = love.audio.newSource("/Soundtracks/Chip03.mp3"),
		Chip04 = love.audio.newSource("/Soundtracks/Chip04.mp3")
	}
	Player = {
		X = 300,
		Y = 300,
		Image = Texture.PlayerR,
		Points = 0,
		Dead = false,
		cooldown = 0,
		Inventory = {},
		Flippers = false,
		RedKey = false,
		BlueKey = false,
		GreenKey = false,
		YellowKey = false,
		FireShoes = false,
		HoverBoots = false
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
	}
	Floor = {}
	Special = {
		conveyor = 0,
		bounceball = 0,
	}
	BeatStage = false;
	for i = 1,13 do
		Plate = {}
		Plate.X = 0
		Plate.Y = 50*(i-1)
		table.insert(Floor, Plate)
		for v = 1,13 do
			Plate = {}
			Plate.X = 50*(v-1)
			Plate.Y = 50*(i-1)
			table.insert(Floor, Plate)
		end
	end
	StageIndex = {"One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Eleven"}
	index = {"Chip01","Chip02"}--,"Chip03","Chip04","Chip05"
	MusicIndex = index[love.math.random(#index)]

	CurrentStage = "test"
	local KEK = {["up"]={x=0,y=(-50)},["down"]={x=0,y=50},["right"]={x=50,y=0},["left"]={x=(-50),y=0}}
	function ResetStage(Lnext)
		for i = 1,10 do
			for _,v in pairs(Workspace)do
				for t,i in pairs(v)do
					table.remove(v,t)
				end
			end
		end
		Player.Points = 0
		Player.Y = 300
		Player.X = 300
		Player.image = Texture.PlayerR
		for i,_ in pairs(Player.Inventory)do
			Player.Inventory[i] = false;
		end
		if Lnext then
			CurrentStage = CurrentStage + 1
		end
		Stage.LevelName = ""
		local File = {}
		if CurrentStage == "test"then
			for line in love.filesystem.lines("/Levels/TestStage")do
				table.insert(File,line)
			end
		else
			for line in love.filesystem.lines("/Levels/Stage"..CurrentStage)do
				table.insert(File,line)
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
	function gayloop(k)
		for i,v in pairs(Workspace)do
			if i == "Water"then
				for _,v in pairs(v)do
					if (v.Y == Player.Y+KEK[k].y)and(v.X == Player.X+KEK[k].x)then
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
					if (v.Y == Player.Y+KEK[k].y)and(v.X == Player.X+KEK[k].x)then Sound.Wall:play()return end
				end
			end
			if i == "KexDoor" then
				for _,v in pairs(v)do
					if (v.Y == Player.Y+KEK[k].y)and(v.X==Player.X+KEK[k].x)and(KexLeft ~= 0) then Sound.Wall:play()return end
				end
			end
			if i == "LockR"then
				for r,f in pairs(v)do
					if (f.Y == Player.Y+KEK[k].y)and(f.X==Player.X+KEK[k].x)then
						if Player.Inventory.RedKey then
							table.remove(v,r)
							Player.Inventory.RedKey=false;
							Sound.Unlock:play()
						else Sound.Wall:play()return end
					end
				end
			end
			if i == "LockB"then
				for r,f in pairs(v)do
					if (f.Y == Player.Y+KEK[k].y)and(f.X==Player.X+KEK[k].x)then
						if Player.Inventory.BlueKey then
							table.remove(v,r)
							Player.Inventory.BlueKey=false
							Sound.Unlock:stop()
							Sound.Unlock:play()
						else Sound.Wall:play()return end
					end
				end
			end
			if i == "LockG"then
				for r,f in pairs(v)do
					if (f.Y==Player.Y+KEK[k].y)and(f.X==Player.X+KEK[k].x)then
						if Player.Inventory.GreenKey then
							table.remove(v,r)
							Player.Inventory.GreenKey=false
							Sound.Unlock:stop()
							Sound.Unlock:play()
						else Sound.Wall:play()return end
					end
				end
			end
			if i == "LockY"then
				for r,f in pairs(v)do
					if (f.Y==Player.Y+KEK[k].y)and(f.X==Player.X+KEK[k].x)then
						if Player.Inventory.YellowKey then
							table.remove(v,r)
							Player.Inventory.YellowKey=false
							Sound.Unlock:stop()
							Sound.Unlock:play()
						else Sound.Wall:play()return end
					end
				end
			end
			if i == "Moveable"then
				for z,m in pairs(v)do
					if m.X==Player.X+KEK[k].x and m.Y==Player.Y+KEK[k].y then 
						for n,f in pairs(Workspace)do
							for w,c in pairs(f)do
								if c.X == m.X+KEK[k].x and c.Y == m.Y+KEK[k].y then
									if n=="Water"or n=="Bomb"then
										table.remove(f,w)
										table.remove(v,z)
										if n=="Water"then
											d={};d.X=c.X;d.Y=c.Y
											table.insert(Workspace["Dirt"],d)
											Sound.Splash:play()
										else
											Sound.Burn:play()
										end
									else Sound.Wall:play()return end
								end
							end
						end
						m.X = m.X+KEK[k].x
						m.Y = m.Y+KEK[k].y
					end
				end
			end
			if i=="Thief"then
				for _,v in pairs(v)do
					if (v.Y == Player.Y+KEK[k].y)and(v.X == Player.X+KEK[k].x)then 
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
					if (f.Y==Player.Y+KEK[k].y)and(f.X==Player.X+KEK[k].x)then
						if Player.Inventory.FireShoes then
							Sound.Burn:play()
						else
							Sound.Burn:stop()
							Sound.Burn:play()
							Player.Dead = true
						end
					end
				end
			end
			if i == "Bomb"then
				for _,f in pairs(v)do
					if f.X==Player.X+KEK[k].x and f.Y==Player.Y+KEK[k].y then
						Sound.Burn:play()
						Player.Dead=true;
					end
				end
			end
		end
		for _,v in pairs(Workspace)do
			for _,i in pairs(v)do
				i.X = i.X + (-KEK[k].x)
				i.Y = i.Y + (-KEK[k].y)
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
					if z.Y==Player.Y-KEK[k].y and z.X==Player.X-KEK[k].x then
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
		end
	end
	function Place(t,x,y)
		if t=="#"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Block"],a)
		elseif t=="o"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Portal"],a)
		elseif t=="W"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Flippers"],a)
		elseif t=="w"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Water"],a)
		elseif t=="k"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Point"],a)
		elseif t=="h"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["KexDoor"],a)
		elseif t=="R"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["RedKey"],a)
		elseif t=="B"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["BlueKey"],a)
		elseif t=="G"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["GreenKey"],a)
		elseif t=="Y"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["YellowKey"],a)
		elseif t=="r"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["LockR"],a)
		elseif t=="b"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["LockB"],a)
		elseif t=="g"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["LockG"],a)
		elseif t=="y"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["LockY"],a)
		elseif t=="m"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Moveable"],a)
		elseif t=="t"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Thief"],a)
		elseif t=="f"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Fire"],a)
		elseif t=="F"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Fireshoes"],a)
		elseif t=="v"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["ConD"],a)
		elseif t=="^"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["ConU"],a)
		elseif t=="<"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["ConL"],a)
		elseif t==">"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["ConR"],a)
		elseif t=="-"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["ButtonBlock"],a)
		elseif t=="V"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["HoverBoots"],a)
		elseif t=="d"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Dirt"],a)
		elseif t=="Q"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["Bomb"],a)
		elseif t=="O"then
			local a={X=x*50,Y=y*50}
			table.insert(Workspace["BounceBall"],a)
		elseif t==","then
			for _,v in pairs(Workspace)do
				for _,f in pairs(v)do
					f.X = f.X - 50
				end
			end
		elseif t=="."then
			for _,v in pairs(Workspace)do
				for _,f in pairs(v)do
					f.Y = f.Y - 50
				end
			end
		end
	end
	Music[MusicIndex]:setVolume(0.4) --0.5
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
		Music[MusicIndex]:play()
	end
	if key =="m"then
		Music[MusicIndex]:setVolume(0) --0.5
	end
	if key=="r"then
		ResetStage()
		Player.Image = Texture.PlayerR
	end
end
function love.update()
	Music[MusicIndex]:play()
	if Player.Dead then return end
	if BeatStage then return end

	if #Workspace["BounceBall"]>=1 then
		Special.bounceball = Special.bounceball + 1
		for _,v in pairs(Workspace["BounceBall"])do
			v.X = v.X + 1
		end
	end

	if #Workspace["ConD"]>=1 or#Workspace["ConL"]>=1 or#Workspace["ConR"]>=1 or#Workspace["ConU"]>=1 then
		if Special.conveyor == 5 then
			Special.conveyor = 0
			for e,f in pairs(Workspace)do
				if Player.Inventory.HoverBoots then break end
				if e == "ConD"then
					for _,f in pairs(f)do
						if (f.Y==Player.Y)and(f.X==Player.X)then
							gayloop("down")
							check("down")
							break
						end
					end
				end
				if e == "ConL"then
					for _,f in pairs(f)do
						if (f.Y==Player.Y)and(f.X==Player.X)then
							gayloop("left")
							check("left")
							break
						end
					end
				end
				if e == "ConR"then
					for _,f in pairs(f)do
						if (f.Y==Player.Y)and(f.X==Player.X)then
							gayloop("right")
							check("right")
							break
						end
					end
				end
				if e == "ConU"then
					for _,f in pairs(f)do
						if (f.Y==Player.Y)and(f.X==Player.X)then
							gayloop("up")
							check("up")
							break
						end
					end
				end
			end
		end
		Special.conveyor = Special.conveyor + 1
	end

	Player.cooldown = Player.cooldown + 1
	if love.keyboard.isDown("up")then
		if Player.cooldown >= 10 then
			Player.cooldown = 0
			Player.Image = Texture.PlayerU
			gayloop("up")
			check("up")
		end
	elseif love.keyboard.isDown("down")then
		if Player.cooldown >= 10 then
			Player.cooldown = 0
			Player.Image = Texture.PlayerD
			gayloop("down")
			check("down")
		end
	elseif love.keyboard.isDown("right")then
		if Player.cooldown >= 10 then
			Player.cooldown = 0
			Player.Image = Texture.PlayerR
			gayloop("right")
			check("right")
		end
	elseif love.keyboard.isDown("left")then
		if Player.cooldown >= 10 then
			Player.cooldown = 0
			Player.Image = Texture.PlayerL
			gayloop("left")
			check("left")
		end
	end
	if Player.image == Texture.Splash then
		Player.image = Texture.PlayerL
	end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	for _, v in pairs(Floor)do love.graphics.draw(Texture.Plate,v.X,v.Y)end
	for i,v in pairs(Workspace)do
		for c,f in pairs(v)do
			if i == "YellowKey"then
				love.graphics.setColor(255,200,0)
				love.graphics.draw(Texture.Key,f.X,f.Y)
			elseif i == "GreenKey"then
				love.graphics.setColor(0,255,0)
				love.graphics.draw(Texture.Key,f.X,f.Y)
			elseif i == "BlueKey"then
				love.graphics.setColor(0,0,255)
				love.graphics.draw(Texture.Key,f.X,f.Y)
			elseif i == "RedKey"then
				love.graphics.setColor(255,0,0)
				love.graphics.draw(Texture.Key,f.X,f.Y)
			elseif i == "Dirt"then
				love.graphics.setColor(102,51,0)
				love.graphics.rectangle("fill",f.X,f.Y,50,50)
			else
				love.graphics.setColor(255,255,255)
				love.graphics.draw(Texture[i],f.X,f.Y)
			end
		end
	end
	love.graphics.draw(Player.Image,Player.X,Player.Y)
	love.graphics.setColor(100,100,100)
	love.graphics.rectangle("fill",650,0,250,650)
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("line",650,0,250,650)
	if CurrentStage == "test"then
		love.graphics.print("Level TEST\nTigerKeks left: "..KexLeft,655,10)
	else
		love.graphics.print("Level "..StageIndex[CurrentStage].."\nTigerKeks left: "..KexLeft,655,10)
	end
	love.graphics.setColor(255,255,255)
	love.graphics.draw(Texture.Inv,650,500)
	
	if Player.Inventory.Flippers then
		love.graphics.draw(Texture.Flippers,650,550)
	end
	if Player.Inventory.FireShoes then
		love.graphics.draw(Texture.Fireshoes,700,550)
	end
	if Player.Inventory.RedKey then
		love.graphics.setColor(255,0,0)
		love.graphics.draw(Texture.Key,650,500)
		love.graphics.setColor(0,0,0)
	end
	if Player.Inventory.BlueKey then
		love.graphics.setColor(0,0,255)
		love.graphics.draw(Texture.Key,700,500)
		love.graphics.setColor(0,0,0)
	end
	if Player.Inventory.GreenKey then
		love.graphics.setColor(0,255,0)
		love.graphics.draw(Texture.Key,750,500)
		love.graphics.setColor(0,0,0)
	end
	if Player.Inventory.YellowKey then
		love.graphics.setColor(255,200,0)
		love.graphics.draw(Texture.Key,800,500)
		love.graphics.setColor(0,0,0)
	end
	if Player.Inventory.HoverBoots then
		love.graphics.setColor(255,255,255)
		love.graphics.draw(Texture.HoverBoots,750,550)
		love.graphics.setColor(0,0,0)
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