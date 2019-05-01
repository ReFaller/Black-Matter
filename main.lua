-----------------------------------------------------------------------------------------------

--[[ Development for GameJam https://itch.io/jam/open-source-transactive-250 © ReFall 2019 ]]--

-----------------------------------------------------------------------------------------------
-- for buttons
local widget = require( "widget" )
-- for mobiles
display.setStatusBar( display.HiddenStatusBar )

-- current level
local level=1

-- * level editor: 
--                0 - empty
--     {\__/}     1 - ball
--     ( •-•)     2 - exit
--     / >↔>      3 - block target
--     © DEV      4 - static block
--                5 - 1-turn block
--                6 - 2-turn block
--                7 - 3-turn block
local getLvl = function(lvlp)
if lvlp == 1 then
	map={
---------1-2-3-4-5-6-7-8---> X-cell	
--[[1]]	{4,4,4,4,4,4,4,4},
--[[2]]	{4,3,0,0,0,0,4,4},
--[[3]]	{4,5,0,0,0,0,4,4},
--[[4]]	{4,0,0,0,0,0,2,4},
--[[5]]	{4,1,0,0,0,0,0,4},
--[[6]]	{4,4,4,4,4,4,4,4}}
--[[Y-cell]]
elseif lvlp == 2 then
	map={
---------1-2-3-4-5-6-7-8---> X-cell	
--[[1]]	{4,0,0,0,0,0,0,0},
--[[2]]	{4,0,0,0,0,0,0,0},
--[[3]]	{4,0,0,1,0,0,0,0},
--[[4]]	{2,0,0,0,0,6,0,3},
--[[5]]	{0,0,0,0,0,0,0,0},
--[[6]]	{0,0,0,0,0,0,0,0}}
--[[Y-cell]]
elseif lvlp == 3 then
	map={
---------1-2-3-4-5-6-7-8---> X-cell	
--[[1]]	{0,5,0,5,0,0,0,0},
--[[2]]	{0,0,0,0,0,0,0,0},
--[[3]]	{4,5,0,5,3,0,0,0},
--[[4]]	{0,0,0,0,0,1,0,0},
--[[5]]	{0,0,0,0,0,0,2,4},
--[[6]]	{0,0,5,3,0,0,0,0}}
--[[Y-cell]]
elseif lvlp == 4 then
	map={
---------1-2-3-4-5-6-7-8---> X-cell	
--[[1]]	{4,0,0,0,0,5,0,0},
--[[2]]	{4,1,0,0,0,0,0,0},
--[[3]]	{0,0,0,7,0,4,0,4},
--[[4]]	{0,0,0,0,0,3,0,2},
--[[5]]	{4,0,0,4,0,4,0,0},
--[[6]]	{4,0,0,0,0,0,0,0}}
--[[Y-cell]]
elseif lvlp == 5 then
	map={
---------1-2-3-4-5-6-7-8---> X-cell	
--[[1]]	{0,0,0,5,0,0,0,0},
--[[2]]	{0,0,0,0,0,0,0,0},
--[[3]]	{0,2,0,6,0,0,0,0},
--[[4]]	{5,0,0,6,0,3,0,5},
--[[5]]	{0,0,0,3,0,1,0,0},
--[[6]]	{0,0,0,5,0,0,0,0}}
--[[Y-cell]]
elseif lvlp == 6 then
	map={
---------1-2-3-4-5-6-7-8---> X-cell	
--[[1]]	{0,0,0,5,0,0,0,0},
--[[2]]	{0,0,0,0,0,0,0,0},
--[[3]]	{0,0,0,0,0,0,0,0},
--[[4]]	{3,0,6,6,6,0,3,0},
--[[5]]	{0,2,3,1,0,0,0,5},
--[[6]]	{0,0,0,5,0,0,0,0}}
--[[Y-cell]]
elseif lvlp == 7 then
	map={
---------1-2-3-4-5-6-7-8---> X-cell	
--[[1]]	{0,0,7,0,0,0,0,0},
--[[2]]	{0,0,0,0,0,2,0,0},
--[[3]]	{0,0,0,0,0,0,0,0},
--[[4]]	{3,5,5,0,0,0,0,5},
--[[5]]	{0,0,0,0,5,0,0,0},
--[[6]]	{0,0,0,0,0,0,0,1}}
--[[Y-cell]]
elseif lvlp == 8 then
	map={
---------1-2-3-4-5-6-7-8---> X-cell	
--[[1]]	{0,0,0,0,0,0,0,0},
--[[2]]	{0,0,5,0,5,0,0,2},
--[[3]]	{0,0,0,6,0,0,0,0},
--[[4]]	{0,0,6,1,6,0,3,0},
--[[5]]	{0,0,0,6,0,3,0,0},
--[[6]]	{0,0,0,0,0,0,0,0}}
--[[Y-cell]]
end
return map
end

-- request for next level or restart current level
local task=nil


sound_z1 = audio.loadSound( "sound/zip.wav" )
sound_z2 = audio.loadSound( "sound/zip2.wav" )
sound_bl1 = audio.loadSound( "sound/block.wav" )
sound_bl2 = audio.loadSound( "sound/block2.wav" )
sound_open = audio.loadSound( "sound/open.wav" )
sound_close = audio.loadSound( "sound/close.wav" )

-- add sprite animation sequence
local addBallAn = function()
local options = {
  width = 90,
  height = 90,
  numFrames = 5,
      sheetContentWidth = 450,  -- width of original 1x size of entire sheet
      sheetContentHeight = 90  -- height of original 1x size of entire sheet
    }
    ballframes =
    {{
    name="an1",
    frames={1,2,3,4,5},
    time=400,
      loopCount = 0,   -- Optional ; default is 0 (loop indefinitely)
      loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
      },{
      name="an2",
      frames={1,2,3,4,5},
      time=500,
      loopCount = 0,
      loopDirection = "forward"
      }}
      ballan  = graphics.newImageSheet("g/ball.png", options )
end
local addBlockSheet = function()
local options = {
  width = 90,
  height = 90,
  numFrames = 9,
      sheetContentWidth = 810,  -- width of original 1x size of entire sheet
      sheetContentHeight = 90  -- height of original 1x size of entire sheet
    }
    blockframes =
    {{
    name="frames",
    frames={1,2,3,4,5,6,7,8,9},
    time=500,
      loopCount = 0,   -- Optional ; default is 0 (loop indefinitely)
      loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
    },{
      name="frames2",
      frames={1,2,3,4,5,6,7,8,9},
      time=500,
      loopCount = 0,
      loopDirection = "forward"
    }}
    blockan  = graphics.newImageSheet("g/cells.png", options )
end
local addExitSheet = function()
local options = {
  width = 90,
  height = 90,
  numFrames = 4,
      sheetContentWidth = 360,  -- width of original 1x size of entire sheet
      sheetContentHeight = 90  -- height of original 1x size of entire sheet
    }
    exitframes =
    {{
    name="an1",
    frames={1,2,3,4},
    time=300,
      loopCount = 1,   -- Optional ; default is 0 (loop indefinitely)
      loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
    },{
      name="an2",
      frames={4,3,2,1},
      time=300,
      loopCount = 1,
      loopDirection = "forward"
    }}
      exitan  = graphics.newImageSheet("g/exit.png", options )
end

addBallAn()
addBlockSheet()
addExitSheet()

-- Touch ground for touch listener
local tapg = display.newGroup()
local tap = display.newRect(tapg,0,0,display.contentWidth,display.contentHeight)
tap.x = display.contentCenterX
tap.y = display.contentCenterY



-- background
local bg = display.newGroup()
local mybg = display.newImageRect(bg, "g/bg.png", display.actualContentWidth, display.actualContentHeight )
mybg.x = display.contentCenterX
mybg.y = display.contentCenterY
-- overlay
local overlay = display.newGroup()
local frame = display.newLine(overlay, 40, 49, 760, 49, 760, 590, 40, 590, 40, 49)
frame.strokeWidth = 2
frame:setStrokeColor( 0, 0.2)
local ovbg = display.newImageRect(overlay, "g/overlay.png", display.actualContentWidth, display.actualContentHeight )
ovbg.x = display.contentCenterX
ovbg.y = display.contentCenterY


myFont = native.newFont( "gil.ttf", 20 )
myText = display.newEmbossedText(overlay, "0", display.actualContentWidth/2, 13, myFont, 24 )
myText:setFillColor( 0.3 )
myText:setText( "BLACK MATTER" )
myText2 = display.newEmbossedText(overlay, "0", 6, 36, myFont, 20 )
myText2:setFillColor( 0.4 )
myText2.anchorX=0
myText2:setText( "LEVEL "..level )
myText3 = display.newEmbossedText(overlay, "0", 800-3, 39, myFont, 12 )
myText3:setFillColor( 0.4 )
myText3.anchorX=1
myText3:setText( "© ReFall 2019" )
myText4 = display.newEmbossedText(overlay, "0", 800-3, 12, myFont, 14 )
myText4:setFillColor( 0.4 )
myText4.anchorX=1
myText4:setText( "Open Source browser Game Jam" )


local marr=nil
local moarr=nil
local ball=nil
local exit=nil
local rball=nil
local lball=nil
local cball=nil
local tempel=nil
local blockmove="stop"
local newcx=0
local newcy=0
local cellnewinx=nil
local mover="s"
local ballx=0
local bally=0
local blockarr={}
local objarr={}
local exitopen=false
local nextlevel=false
local hideball=false
local hidescene=false
local showscene=false
function checkExit()
local checksum=0
local exitcell=false
		for i=1,8 do 
			for j=1,6 do
				if moarr[i][j]==3 then
					checksum=checksum+1
					if marr[j][i]>=4 then
						checksum=checksum-1
					end
				elseif moarr[i][j]==2 and ballx==i and bally==j then
					exitcell=true
				end
			end
		end
		if checksum==0 then
			    if not exitopen then
		       	exit:setSequence("an1")
           		exit:play()	
           		exitopen=true
           		audio.play(sound_open)
           		end
		else
				if exitopen then
		       	exit:setSequence("an2")
           		exit:play()	
           		exitopen=false
           		audio.play(sound_close)
           		end
		end
		if exitopen and exitcell then
			nextlevel=true
			task="next"
		end
end

local level1 = display.newGroup() -- min layer depth (for target)
local level2 = display.newGroup() -- blocks
local level3 = display.newGroup() -- temp
local level4 = display.newGroup() -- max layer depth (for ball)
local level5 = display.newGroup() -- next level (layer changer) 

local levelchanger = display.newRect(level5,0,0,display.contentWidth,display.contentHeight)
levelchanger:setFillColor(0.8)
levelchanger.x = display.contentCenterX
levelchanger.y = display.contentCenterY
levelchanger.isVisible=false



local function handleButtonEvent( event )
 
    if ( "ended" == event.phase ) then
       if(event.target.id=="b1") then
       task="prev"
       hidescene=true
 		levelchanger.isVisible=true
 		levelchanger.alpha=0
       elseif(event.target.id=="b2") then
       task="restart"
       hidescene=true
 		levelchanger.isVisible=true
 		levelchanger.alpha=0
       elseif(event.target.id=="b3") then
       task="next"
       hidescene=true
 		levelchanger.isVisible=true
 		levelchanger.alpha=0
       end
    end
end

local buttoptions = {
    width = 24,
    height = 24,
    numFrames = 2,
    sheetContentWidth = 48,
    sheetContentHeight = 24
}
local buttonSheet = graphics.newImageSheet( "g/butprev.png", buttoptions )
local butt1 = widget.newButton(
    {
        sheet = buttonSheet,
        id = "b1",
        defaultFrame = 1,
        overFrame = 2,
        onEvent = handleButtonEvent
    }
)
butt1.x=13
butt1.y=13
level4:insert( butt1 )
local buttonSheet = graphics.newImageSheet( "g/restart.png", buttoptions )
local butt2 = widget.newButton(
    {
        sheet = buttonSheet,
        id = "b2",
        defaultFrame = 1,
        overFrame = 2,
        onEvent = handleButtonEvent
    }
)
butt2.x=13+25
butt2.y=13
level4:insert( butt2 )
local buttonSheet = graphics.newImageSheet( "g/butnext.png", buttoptions )
local butt3 = widget.newButton(
    {
        sheet = buttonSheet,
        id = "b3",
        defaultFrame = 1,
        overFrame = 2,
        onEvent = handleButtonEvent
    }
)
butt3.x=13+50
butt3.y=13
level4:insert( butt3 )

function drawLvl()
	marr=getLvl(level)
	moarr={}
	for i=1,8 do 
		blockarr[i]={}
		objarr[i]={}
		moarr[i]={}
		for j=1,6 do
			if marr[j][i]==1 then
				ball = display.newSprite(level4, ballan, ballframes )
				newcx = 40+i*90-44
            	newcy = 50+j*90-44
    			ball.x=newcx
    			ball.y=newcy
            	ballx=i
            	bally=j
				ball.fill.effect = "filter.scatter"
				ball.fill.effect.intensity = 0.03
            	ball:setSequence("an1")
           		ball:play()
           	elseif marr[j][i]==2 then
           		moarr[i][j]=2
           		exit = display.newSprite(level1, exitan, exitframes )
           		exit.x = 40+i*90-45
    			exit.y = 50+j*90-45
           		exit:setSequence("an1")
           	elseif marr[j][i]==3 then
           		moarr[i][j]=3
				objarr[i][j]=display.newImageRect(level1, "g/check.png", 90, 90 )
				objarr[i][j].x=40+i*90-45
				objarr[i][j].y=50+j*90-45
			elseif marr[j][i]==4 then
				blockarr[i][j]=display.newImageRect(level2, "g/cell.png", 90, 90 )
				blockarr[i][j].x=40+i*90-45
				blockarr[i][j].y=50+j*90-45
			elseif marr[j][i]==5 then
				blockarr[i][j] = display.newSprite(level2, blockan, blockframes )
				blockarr[i][j].x=40+i*90-45
				blockarr[i][j].y=50+j*90-45
				blockarr[i][j]:setSequence("frames")
				blockarr[i][j]:setFrame(1)
			elseif marr[j][i]==6 then
				blockarr[i][j] = display.newSprite(level2, blockan, blockframes )
				blockarr[i][j].x=40+i*90-45
				blockarr[i][j].y=50+j*90-45
				blockarr[i][j]:setSequence("frames")
				blockarr[i][j]:setFrame(2)
			elseif marr[j][i]==7 then
				blockarr[i][j] = display.newSprite(level2, blockan, blockframes )
				blockarr[i][j].x=40+i*90-45
				blockarr[i][j].y=50+j*90-45
				blockarr[i][j]:setSequence("frames")
				blockarr[i][j]:setFrame(3)
			end

		end
	end
end


function newBlock(barr, oarr)
if barr==5 then
	if oarr~=nil then
	audio.play(sound_bl2)
	return {9, 4}
	else
	audio.play(sound_bl1)
	return {8, 4}
	end
elseif barr==6 then
	if oarr~=nil then
	audio.play(sound_bl2)
	return {4, 5}
	else
	audio.play(sound_bl1)
	return {1, 5}
	end
elseif barr==7 then
	if oarr~=nil then
	audio.play(sound_bl2)
	return {5, 6}
	else
	audio.play(sound_bl1)
	return {2, 6}
	end
end	
end
local function myTouchListener( event )
    if ( event.phase == "began" ) then
    	if not hideball then
    	local oldx=ball.x
    	local oldy=ball.y
    	local ncx=ball.x-event.x
    	local ncy=ball.y-event.y
    	local kxy=math.max(math.abs(ncx),math.abs(ncy))
    	if mover~="s" then
    	removeAnimation()
    	if ball~=nil then
    	ball.x=newcx
    	ball.y=newcy
   		end
    	end
    	if kxy==math.abs(ncx) then
    	if ncx<0 then
    		print("right")
    		audio.play(sound_z2)
    		for i=ballx,8 do
    			if marr[bally][i]>=0 and marr[bally][i]<=3 then
    				ballx=i
    			elseif marr[bally][i]==4 then
    				break
    			elseif marr[bally][i]>=5 then
    				if i<8 and marr[bally][i+1]~=nil and marr[bally][i+1]<4 then
    				local tempi=newBlock(marr[bally][i], objarr[i+1][bally])
    				marr[bally][i]=0
    				marr[bally][i+1]=tempi[2]
    				cellnewinx=tempi[1]
    				tempel=blockarr[i][bally]
    				tempel:setFrame(7)
    				tempel.x=40+(i+1)*90
    				tempel.anchorX=1
    				tempel.width=180
    				--tempel:setFillColor( 0, 0, 0)
    				blockarr[i][bally]=nil
    				blockarr[i+1][bally]=tempel
    				end
    				break
    			end
    		end
    		newcx=40+ballx*90-44
    		cball = display.newImageRect("g/cb.png", 90, 90 )
    		cball.fill.effect = "filter.scatter"
			cball.fill.effect.intensity = 0.1
			cball.anchorX=0
    		cball.x=oldx-2
    		cball.y=oldy+1
    		cball.width=math.abs(newcx-oldx)+28
    		lball = display.newImageRect("g/lb.png", 90, 90 )
    		lball.fill.effect = "filter.scatter"
			lball.fill.effect.intensity = 0.1
    		lball.x=oldx
    		lball.y=oldy+1
    		rball = display.newImageRect("g/rb.png", 90, 90 )
    		rball.fill.effect = "filter.scatter"
			rball.fill.effect.intensity = 0.1
    		rball.x=newcx+26
    		rball.y=oldy+1
    		ball.x=newcx+26
    		ball.isVisible=false
    		mover="r"
    	elseif ncx>0 then
    		print("left")
    		audio.play(sound_z2)
    		for i=ballx,1,-1 do
    			if marr[bally][i]>=0 and marr[bally][i]<=3 then
    				ballx=i
    			elseif marr[bally][i]==4 then
    				break
    			elseif marr[bally][i]>=5 then
    				if i>1 and marr[bally][i-1]~=nil and marr[bally][i-1]<4 then
    				local tempi=newBlock(marr[bally][i], objarr[i-1][bally])
    				marr[bally][i]=0
    				marr[bally][i-1]=tempi[2]
    				cellnewinx=tempi[1]
    				tempel=blockarr[i][bally]
    				tempel:setFrame(7)
    				tempel.x=40+(i-1)*90-90
    				tempel.anchorX=0
    				tempel.width=180
    				blockarr[i][bally]=nil
    				blockarr[i-1][bally]=tempel
    				end
    				break
    			end
    		end
    		newcx=40+ballx*90-44
    		cball = display.newImageRect("g/cb.png", 90, 90 )
    		cball.fill.effect = "filter.scatter"
			cball.fill.effect.intensity = 0.1
			cball.anchorX=1
    		cball.x=oldx
    		cball.y=oldy+1
    		cball.width=math.abs(newcx-oldx)+28
    		rball = display.newImageRect("g/rb.png", 90, 90 )
    		rball.fill.effect = "filter.scatter"
			rball.fill.effect.intensity = 0.1
    		rball.x=oldx
    		rball.y=oldy+1
    		lball = display.newImageRect("g/lb.png", 90, 90 )
    		lball.fill.effect = "filter.scatter"
			lball.fill.effect.intensity = 0.1
    		lball.x=newcx-26
    		lball.y=oldy+1
    		ball.x=newcx-26
    		ball.isVisible=false
    		mover="l"
    	end
    	else
    	if ncy<0 then
    		print("down")
    		audio.play(sound_z2)
    		for j=bally,6 do
    			if marr[j][ballx]>=0 and marr[j][ballx]<=3 then
    				bally=j
    			elseif marr[j][ballx]==4 then
    				break
    			elseif marr[j][ballx]>=5 then
    				if j<6 and marr[j+1][ballx]~=nil and marr[j+1][ballx]<4 then
    				local tempi=newBlock(marr[j][ballx], objarr[ballx][j+1])
    				marr[j][ballx]=0
    				marr[j+1][ballx]=tempi[2]
    				cellnewinx=tempi[1]
    				tempel=blockarr[ballx][j]
    				tempel:setFrame(7)
    				tempel.y=50+(j+1)*90
    				tempel.anchorY=1
    				tempel.height=180
    				--tempel:setFillColor( 0, 0, 0)
    				blockarr[ballx][j]=nil
    				blockarr[ballx][j+1]=tempel
    				end
    				break
    			end
    		end
    		newcy=50+bally*90-44
    		cball = display.newImageRect("g/tb.png", 90, 90 )
    		cball.fill.effect = "filter.scatter"
			cball.fill.effect.intensity = 0.1
			cball.anchorY=0
    		cball.x=oldx
    		cball.y=oldy-3
    		cball.height=math.abs(newcy-oldy)+29
    		rball = display.newImageRect("g/ub.png", 90, 90 )
    		rball.fill.effect = "filter.scatter"
			rball.fill.effect.intensity = 0.1
    		rball.x=oldx
    		rball.y=oldy
    		lball = display.newImageRect("g/db.png", 90, 90 )
    		lball.fill.effect = "filter.scatter"
			lball.fill.effect.intensity = 0.1
    		lball.x=oldx
    		lball.y=newcy+26
    		ball.y=newcy+26
    		ball.isVisible=false
    		mover="d"
    	elseif ncy>0 then
    		print("up")
    		audio.play(sound_z2)
    		for j=bally,1,-1 do
    			if marr[j][ballx]>=0 and marr[j][ballx]<=3 then
    				bally=j
    			elseif marr[j][ballx]==4 then
    				break
    			elseif marr[j][ballx]>=5 then
    				if j>1 and marr[j-1][ballx]~=nil and marr[j-1][ballx]<4 then
    				local tempi=newBlock(marr[j][ballx], objarr[ballx][j-1])
    				marr[j][ballx]=0
    				marr[j-1][ballx]=tempi[2]
    				cellnewinx=tempi[1]
    				tempel=blockarr[ballx][j]
    				tempel:setFrame(7)
    				tempel.y=50+(j-1)*90-90
    				tempel.anchorY=0
    				tempel.height=180
    				--tempel:setFillColor( 0, 0, 0)
    				blockarr[ballx][j]=nil
    				blockarr[ballx][j-1]=tempel
    				end
    				break
    			end
    		end
    		newcy=50+bally*90-44
    		cball = display.newImageRect("g/tb.png", 90, 90 )
    		cball.fill.effect = "filter.scatter"
			cball.fill.effect.intensity = 0.1
			cball.anchorY=1
    		cball.x=oldx
    		cball.y=oldy
    		cball.height=math.abs(newcy-oldy)+29
    		lball = display.newImageRect("g/db.png", 90, 90 )
    		lball.fill.effect = "filter.scatter"
			lball.fill.effect.intensity = 0.1
    		lball.x=oldx
    		lball.y=oldy
    		rball = display.newImageRect("g/ub.png", 90, 90 )
    		rball.fill.effect = "filter.scatter"
			rball.fill.effect.intensity = 0.1
    		rball.x=oldx
    		rball.y=newcy-26
    		ball.y=newcy-26
    		ball.isVisible=false
    		mover="u"
    	end
    	end
    end
    elseif ( event.phase == "moved" ) then
    elseif ( event.phase == "ended" ) then
    end
    return true
end
tap:addEventListener( "touch", myTouchListener )


function removeAnimation()
		if lball~= nil and cball~= nil and rball~=nil then
		display.remove(lball)
		lball=nil
		display.remove(cball)
		cball=nil
		display.remove(rball)
		rball=nil
		ball.isVisible=true
		end
		if tempel~=nil then
		if blockmove=="linex" then
		tempel.width=90
		elseif blockmove=="liney" then
		tempel.height=90
		end
		tempel:setFrame(cellnewinx)
		blockmove="stop"
		tempel=nil
		end
		checkExit()
end
function enterFrame()
 if hidescene then
 levelchanger.alpha=levelchanger.alpha+0.1
 if levelchanger.alpha>=1 then
 	hidescene=false
 	showscene=true
 	createNewLevel(task)
 end
 elseif showscene then
    levelchanger.alpha=levelchanger.alpha-0.1
    if levelchanger.alpha<=0 then
    showscene=false
    levelchanger.isVisible=false
    end
 else
 if hideball then
 	ball.alpha=ball.alpha-0.1
 	if ball.alpha<=0 then
 		hidescene=true
 		levelchanger.isVisible=true
 		levelchanger.alpha=0
 	end
 else
	if tempel~=nil and cellnewinx~=nil then
	if blockmove=="linex" then
	local tbkoef=math.abs(90-tempel.width)
	tempel.width=tempel.width+(90-tempel.width)/2
	if tbkoef<5 then
	tempel.width=90
	tempel:setFrame(cellnewinx)
	blockmove="stop"
	tempel=nil
	end
	elseif blockmove=="liney" then
	local tbkoef=math.abs(90-tempel.height)
	tempel.height=tempel.height+(90-tempel.height)/2
	if tbkoef<5 then
	tempel.height=90
	tempel:setFrame(cellnewinx)
	blockmove="stop"
	tempel=nil
	checkExit()
	end
	end
	end
	if mover=="r" then
		if lball~=nil then
		local koef=math.abs(lball.x-ball.x)
		if koef>20 then
		lball.x=lball.x+(ball.x-lball.x)/2
		cball.x=lball.x-3
		cball.width=math.abs(lball.x-ball.x)+3
		else
		removeAnimation()
		end
		else
		if tempel~=nil then
		blockmove="linex"
		end
		local tdkoef=math.abs(newcx-ball.x)
		ball.x=ball.x+(newcx-ball.x)/1.5
		if tdkoef<1 then
		mover="s"
		ball.x=newcx
		if nextlevel and not hideball then
			hideball=true
			audio.play(sound_z1)
		end
		end
		end
	elseif mover=="l" then
		if lball~=nil then
		local koef=math.abs(rball.x-ball.x)
		if koef>20 then
		rball.x=rball.x+(ball.x-rball.x)/2
		cball.x=rball.x
		cball.width=math.abs(rball.x-ball.x)+3
		else
		removeAnimation()
		end
		else
		if tempel~=nil then
		blockmove="linex"
		end
		local tdkoef=math.abs(newcx-ball.x)
		ball.x=ball.x+(newcx-ball.x)/1.5
		if tdkoef<1 then
		mover="s"
		ball.x=newcx
		if nextlevel and not hideball then
			hideball=true
			audio.play(sound_z1)
		end
		end
		end
	elseif mover=="d" then
		if lball~=nil then
		local koef=math.abs(rball.y-ball.y)
		if koef>20 then
		rball.y=rball.y+(ball.y-rball.y)/2
		cball.y=rball.y-3
		cball.height=math.abs(rball.y-ball.y)+4
		else
		removeAnimation()
		end
		else
		if tempel~=nil then
		blockmove="liney"
		end
		local tdkoef=math.abs(newcy-ball.y)
		ball.y=ball.y+(newcy-ball.y)/1.5
		if tdkoef<1 then
		mover="s"
		ball.y=newcy
		if nextlevel and not hideball then
			hideball=true
			audio.play(sound_z1)
		end
		end
		end
	elseif mover=="u" then
		if lball~=nil then
		local koef=math.abs(lball.y-ball.y)
		if koef>20 then
		lball.y=lball.y+(ball.y-lball.y)/2
		cball.y=lball.y
		cball.height=math.abs(lball.y-ball.y)+3
		else
		removeAnimation()
		end
		else
		if tempel~=nil then
		blockmove="liney"
		end
		local tdkoef=math.abs(newcy-ball.y)
		ball.y=ball.y+(newcy-ball.y)/1.5
		if tdkoef<1 then
		mover="s"
		ball.y=newcy
		if nextlevel and not hideball then
			hideball=true
			audio.play(sound_z1)
		end
		end
		end
	end
  end
end
end
Runtime:addEventListener("enterFrame", enterFrame)

function clearData()
removeAnimation()
	for i=1,8 do 
		for j=1,6 do
			if objarr[i][j]~=nil then
			display.remove(objarr[i][j])
			objarr[i][j]=nil
			end
			if blockarr[i][j]~=nil then
			display.remove(blockarr[i][j])
			blockarr[i][j]=nil
			end
		end
	end
display.remove(ball)
display.remove(exit)
marr=nil
moarr=nil
ball=nil
exit=nil
rball=nil
lball=nil
cball=nil
tempel=nil
blockmove="stop"
newcx=0
newcy=0
cellnewinx=nil
mover="s"
ballx=0
bally=0
blockarr={}
objarr={}
exitopen=false
nextlevel=false
hideball=false
end
function createNewLevel(req)
	if req~=nil then
	clearData()
	end
	if req=="next" then
		if level<8 then
			level=level+1
		end
	elseif req=="prev" then
		if level>1 then
			level=level-1
		end
	end
	myText2:setText( "LEVEL "..level )
	drawLvl()
	checkExit()
end
createNewLevel()