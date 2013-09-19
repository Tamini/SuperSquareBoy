% Name: PlatformerBossFight.t
% Purpose: Platform Game to play
% Date: June 5, 2011
% Author: Tristan Amini and Jared Nathanson

% Set screen size
setscreen ("graphics:1000;600, offscreenonly, nobuttonbar, nocursor")

% Declare variables and fonts
var playerX, playerY, playerXBig, playerYBig : int
var velocityX, velocityY, checkpoint : int := 0
var count : int := -1
var gravity, level, count2, count3, count4, count5, movePlatX, bossHealth, laserY, laserX, laserY2, laserX2 : int
var canJump, countStart, collisionLeft, collisionRight, objectiveGet, die, textOn, platBack, teleport1, bossDead : boolean := false
var teleport2, bossAttack, switchGet, powerUpGet, bossKill, switchGet2, bossAttackTrigger, laserBack, laserTop, onPlat, back, win : boolean := false
var move : array char of boolean
var font1, font2, health1Count, movePlatY, stop : int
var DSGx, DSGy, DSGBigx, DSGBigy, DSGinc, laserVariant, cageFall, bomb1, bomb2, bomb1X, bomb1Y, bomb2X, bomb2Y : int
DSGinc := 0
font1 := Font.New ("Comic Sans MS:20:bold")
font2 := Font.New ("Comis Sans MS:10:bold")
level := 1
gravity := 2
playerX := 50
playerY := 55
playerXBig := 65
playerYBig := 70
count2 := 0
count3 := 0
movePlatX := 0
bossHealth := 3
count4 := 0
count5 := 0
laserY := 100
laserX := 0
laserX2 := 0
laserY2 := 0
cageFall := 2
health1Count := 0
movePlatY := 200
stop := 2
procedure movement    % Check if on moving platform
    % Get input
    Input.KeyDown (move)
    % Set player X location
    playerX += velocityX
    % Check if jumping is allowed
    if whatdotcolour (playerX, playerY - 1) = black or whatdotcolour (playerXBig, playerY - 1) = black or whatdotcolour (playerX + 7, playerY - 1) = black or whatdotcolour (playerX + 7, playerY -
	    1)
	    = red then
	canJump := true
    else
	playerY += velocityY - gravity
    end if
    % Damage boss
    if whatdotcolour (playerX + 7, playerY - 1) = red then
	bossHealth -= 1
	DSGinc := 0

    end if
    % Check if player hits switch
    if canJump = true and move (KEY_UP_ARROW) then
	velocityY := 6
	playerY += velocityY
	canJump := false
	countStart := true
    end if
    % Reset X velocity
    velocityX := 0
    % Jump counter
    if count = 25 then
	velocityY := 0
	count := 0
	countStart := false
    end if
    % Cheat
    if move ('e') then
	gravity := 0
    else
	gravity := 2
    end if
    % Other points on square location
    playerXBig := playerX + 15
    playerYBig := playerY + 15
    % Draw player
    drawbox (playerX, playerY, playerXBig, playerYBig, brightgreen)
    % Check if power up get.
    if powerUpGet = true then
	drawbox (playerX + 3, playerY + 3, playerXBig - 3, playerYBig - 3, brightgreen)
    end if
    % Update screen
    View.Update
    % Check for player hitting bright red line
    if whatdotcolour (playerX - 1, playerY + 7) = brightred then
	die := true
    elsif whatdotcolour (playerXBig + 1, playerY + 7) = brightred then
	die := true
    elsif playerX < 0 or playerX > maxx then
	die := true
    elsif whatdotcolour (playerX + 7, playerY - 1) = brightred then
	die := true
    elsif whatdotcolour (playerX + 7, playerYBig + 1) = brightred then
	die := true
    elsif whatdotcolour (playerX + 7, playerY - 1) = brightred then
	die := true
    elsif whatdotcolour (playerX - 1, playerY - 1) = brightred then
	die := true
    elsif whatdotcolour (playerXBig, playerY - 1) = brightred then
	die := true
    end if
    % Check that player can move left and right and if the keys are being hit
    if move (KEY_LEFT_ARROW) and collisionLeft = false then
	velocityX := -2
    elsif move (KEY_RIGHT_ARROW) and collisionRight = false then
	velocityX := 2
    end if
    cls
    delay (10)
    % Start counter
    if countStart = true then
	count += 1
    end if
end movement
procedure cutsceneStart
    var ssx, ck : int
    ssx := 200
    ck := 750
    font1 := Font.New ("Comic Sans MS:18:bold")
    setscreen ("graphics:1000;600,offscreenonly")
    drawline (500, 0, 500, 600, black)
    drawbox (ssx, 250, ssx + 100, 350, brightgreen)
    drawoval (ck, 300, 50, 50, brightgreen)
    delay (1000)
    Font.Draw ("Wanna come over?", 700, 455, font1, brightgreen)
    View.Update
    delay (1500)
    cls
    drawline (500, 0, 500, 600, black)
    drawbox (ssx, 250, ssx + 100, 350, brightgreen)
    drawoval (ck, 300, 50, 50, brightgreen)
    Font.Draw ("Sure", 300, 455, font1, brightgreen)
    View.Update
    delay (1500)
    cls
    drawline (500, 0, 500, 600, black)
    drawbox (ssx, 250, ssx + 100, 350, brightgreen)
    drawoval (ck, 300, 50, 50, brightgreen)
    Font.Draw ("See you soon!", 700, 455, font1, brightgreen)
    View.Update
    delay (1500)
    cls
    loop
	cls
	drawline (500, 0, 500, 600, black)
	drawbox (ssx, 250, ssx + 100, 350, brightgreen)
	drawoval (ck, 300, 50, 50, brightgreen)
	if ssx + 110 not= 0 then
	    ssx -= 1
	    ck += 1
	end if
	if ssx + 110 = 0 then
	    exit
	end if
	View.Update
    end loop
    %Increase level
    level += 1
end cutsceneStart
procedure level1
    % Info Text
    Font.Draw ("Get to the blue box to advance!", 100, 550, font1, blue)
    Font.Draw ("Use the up, left and right arrows to move", 550, 400, font2, blue)
    Font.Draw ("Going off the screen will result in a death and the level will restart", 500, 200, font2, blue)
    % Draw platforms
    drawline (-100, 50, maxx, 50, black)
    drawline (0, 100, 100, 100, black)
    drawline (150, 150, 250, 150, black)
    drawline (0, 200, 100, 200, black)
    drawline (150, 250, 250, 250, black)
    drawline (0, 300, 100, 300, black)
    drawline (150, 350, 250, 350, black)
    drawbox (200, 351, 250, 401, blue)
    % Test for death, player redraw, and/or getting objective
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
    end if
    % Objective check
    if playerX > 200 and playerX < 250 and playerY >= 350 and playerY <= 400 then
	objectiveGet := true
    end if
end level1
procedure level2
    % Text
    if textOn = true then
	Font.Draw ("Congratulations! You can jump!", 100, 550, font1, blue)
    end if
    % Platforms
    drawline (-100, 50, maxx, 50, black)
    drawline (0, 150, 250, 150, black)
    drawline (300, 200, 310, 200, black)
    drawline (350, 250, 600, 250, black)
    drawline (700, 300, 715, 300, black)
    drawline (750, 350, maxx, 350, black)
    drawbox (maxx - 50, 351, maxx, 401, brightblue)
    % Text trigger
    if playerY > 360 then
	textOn := true
    end if
    % Test for death, player redraw, and/or getting objective
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
    end if
    % Objective check
    if playerX > maxx - 50 and playerX < maxx and playerY > 350 and playerY < 400 then
	objectiveGet := true
    end if
end level2

procedure level3
    Font.Draw ("Here we have a slant.  Only move to the right on a slant, otherwise you will fall. Also, red platforms will kill you.", 100, 575, font2, blue)
    % Left side
    drawline (-100, 50, maxx, 50, black)
    drawline (355, 50, maxx, 50, brightred)
    drawline (0, 150, 120, 150, black)
    drawline (170, 250, 290, 250, black)
    drawline (0, 350, 120, 350, black)
    drawline (170, 450, 290, 450, black)
    drawline (130, 500, 170, 500, black)
    % Middle obstacle sides and top
    Draw.ThickLine (290, 50, 290, 546, 5, brightred)
    drawline (290, 550, 350, 550, black)
    Draw.ThickLine (350, 50, 350, 546, 5, brightred)
    % Right side platforms
    Draw.ThickLine (470, maxy, 470, maxy - 300, 5, brightred)
    drawline (350, 220, 470, 220, black)
    drawline (575, 150, 695, 150, black)
    drawline (625, 300, 745, 300, black)
    drawline (750, 370, 800, 370, black)
    drawline (900, 330, 950, 330, black)
    drawline (1000, 400, 1300, 400, black)
    % Slant
    Draw.ThickLine (500, 250, 550, 220, 2, black)
    % Finish plat and blue square
    drawline (maxx - 120, 350, maxx, 350, black)
    drawbox (maxx - 50, 351, maxx, 401, brightblue)
    % Death redraw
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
    end if
    % Objective Check
    if playerX > maxx - 50 and playerX < maxx and playerY >= 351 and playerY <= 401 then
	objectiveGet := true
    end if
end level3
procedure level4
    Font.Draw ("This is where it gets exciting.", 100, 575, font1, blue)
    % Ground and left plats
    drawline (0, 50, maxx, 50, black)
    drawline (100, 50, maxx, 50, brightred)
    drawline (0, 150, 100, 150, black)
    drawline (0, 250, 100, 250, black)
    % Moving platform lower
    drawline (movePlatX, 200, movePlatX + 50, 200, black)
    % Moving platform higher
    drawline (movePlatX + 200, 300, movePlatX + 250, 300, black)
    %drawline (movePlatX + 200, 251, movePlatX + 500, 251, brightred)
    % Vertical moving
    Draw.ThickLine (movePlatX + 250, 251, movePlatX + 250, 298, 2, brightred)
    % Middle plat
    drawline (700, 250, 550, 250, black)
    % Final plat and objective
    drawline (850, 350, 1000, 350, black)
    drawbox (950, 351, 1000, 401, brightblue)
    % Death redraw
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
    end if
    % Objective Check
    if playerX > 950 and playerX < 1000 and playerY >= 351 and playerY <= 402 then
	objectiveGet := true
    end if
    % Platform reverse direction check
    if movePlatX + 50 >= 600 then
	platBack := true
    elsif movePlatX <= 0 then
	platBack := false
    end if
    % Platform reverse direction
    if platBack = true then
	movePlatX -= 1
    end if
    if movePlatX = 0 then
	platBack := false
    end if
    if platBack = false then
	movePlatX += 1
    end if
    % Check if on Plat
    if playerY - 1 = 300 or playerY - 1 = 180 or playerY - 1 = 410 or playerY - 1 = 530 or playerY - 1 = 200 or playerY - 1 = 410 then
	if playerX > movePlatX and playerX < movePlatX + 50 or playerX > movePlatX + 200 and playerX < movePlatX + 250 then
	    onPlat := true
	else
	    onPlat := false
	end if
    else
	onPlat := false
    end if
    % Alter player position
    if onPlat = true and platBack = false then
	velocityX += 1
    elsif onPlat = true and platBack = true then
	velocityX -= 1
    end if
end level4
procedure level5
    Font.Draw ("Made especially for you, ENJOY!", 100, 575, font1, blue)
    drawline (0, 50, maxx, 50, black)
    % Black Plats 1
    drawline (0, 150, 100, 150, black)
    drawline (0, 250, 100, 250, black)
    drawline (0, 350, 100, 350, black)
    drawline (0, 450, 100, 450, black)
    drawline (0, 550, 100, 550, black)
    % Black Slant 1
    drawline (100, 550, 200, 500, black)
    % Red Slants 1
    drawline (200, 500, 400, 50, brightred)
    drawline (275, 500, 475, 100, brightred)
    % Red skip stop 1
    drawline (275, 500, 275, maxy, brightred)
    % Black Plats 2
    drawline (550, 150, 650, 150, black)
    drawline (550, 250, 650, 250, black)
    drawline (550, 350, 650, 350, black)
    drawline (550, 450, 650, 450, black)
    drawline (550, 550, 650, 550, black)
    % Black Slant 2
    drawline (650, 550, 750, 500, black)
    % Red Slants 2
    drawline (750, 500, 950, 50, brightred)
    drawline (800, 500, 1000, 50, brightred)
    % Red skip stop 2
    drawline (800, 500, 800, maxy, brightred)
    % Objective
    drawbox (950, 50, 1000, 100, blue)
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
    end if
    if playerX > 950 and playerX < 1000 and playerY >= 50 and playerY <= 100 then
	objectiveGet := true
    end if
end level5
procedure level6
    Font.Draw ("Teleporters! (purple)", 100, 250, font1, blue)
    Font.Draw ("Going through them sometimes brings up messages!", 10, 200, font1, blue)
    drawline (0, 50, maxx, 50, black)
    % Borders
    Draw.ThickLine (700, maxy, 700, 50, 5, brightred)
    Draw.ThickLine (0, 350, 695, 350, 5, brightred)
    % Teleporters set1 (bottom left to top right)
    drawbox (100, 51, 150, 101, purple)
    drawline (maxx - 100, maxy - 100, maxx, maxy - 100, black)
    drawbox (maxx - 50, maxy - 99, maxx - 1, maxy - 49, purple)
    if playerX > 100 and playerX < 150 and playerY > 50 and playerY < 100 and teleport1 = false then
	playerX := maxx - 40
	playerY := maxy - 49
	teleport1 := true
    end if
    % Right platforms
    Draw.ThickLine (maxx, 55, maxx - 295, 55, 5, black)
    drawline (700, 400, 800, 400, brightred)
    drawline (maxx, 350, maxx - 100, 350, brightred)
    Draw.ThickLine (700, 300, 900, 300, 2, brightred)
    Draw.ThickLine (maxx, 200, 865, 200, 2, brightred)
    Draw.ThickLine (maxx, 150, 815, 150, 2, brightred)
    Draw.ThickLine (maxx, 100, 765, 100, 2, brightred)
    % Teleporters set2 (bottom right to top left)
    drawbox (maxx - 10, 58, maxx - 60, 98, purple)
    drawline (0, maxy - 61, 75, maxy - 61, black)
    drawbox (1, maxy - 60, 51, maxy - 10, purple)
    if playerX > maxx - 60 and playerX < maxx - 10 and playerY < 98 and teleport2 = false then
	playerX := 5
	playerY := maxy - 20
	teleport2 := true
    end if
    if teleport2 = true then
	Font.Draw ("Your best friend, Circle Kid, is up ahead!", 100, 100, font1, blue)
    end if
    % Obstacle 2 plats
    Draw.ThickLine (0, maxy - 120, 280, maxy - 120, 2, brightred)
    Draw.ThickLine (280, maxy - 120, 350, maxy - 120, 2, black)
    drawline (350, maxy - 120, 350, 555, brightred)
    % Objective and final plat
    Draw.ThickLine (200, 370, 350, 370, 5, black)
    drawbox (250, 371, 300, 421, blue)
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
	teleport1 := false
	teleport2 := false
    end if
    if playerX > 249 and playerX < 301 and playerY > 371 and playerY < 421 then
	objectiveGet := true
    end if
end level6
procedure cutscene1
    % Cutscene variables
    var redX, ssx, ck : int
    redX := 1200
    ssx := 250
    ck := 285
    % Ground and characters
    drawline (0, 50, maxx, 50, black)
    drawbox (redX, 51, redX + 50, 101, brightred)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    drawoval (ck, 59, 8, 8, brightgreen)
    % First segment
    loop
	drawline (0, 50, maxx, 50, black)
	drawbox (redX, 51, redX + 50, 101, brightred)
	drawbox (ssx, 51, ssx + 15, 66, brightgreen)
	drawoval (ck, 59, 8, 8, brightgreen)
	% Check for end of segment
	if redX = 294 then
	    exit
	end if
	redX -= 1
	View.Update
	cls
    end loop
    % Speech
    Font.Draw ("CIRCLE KID, YOU ARE COMING WITH ME!", 150, 255, font1, brightred)
    % Update screen
    View.Update
    delay (2000)
    cls
    drawline (0, 50, maxx, 50, black)
    drawbox (redX, 51, redX + 50, 101, brightred)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    drawoval (ck, 59, 8, 8, brightgreen)
    Font.Draw ("Okay...", 100, 250, font1, brightgreen)
    View.Update
    delay (2000)
    cls
    % Second segment
    loop
	drawline (0, 50, maxx, 50, black)
	drawbox (redX, 51, redX + 50, 101, brightred)
	drawbox (ssx, 51, ssx + 15, 66, brightgreen)
	drawoval (ck, 59, 8, 8, brightgreen)
	% Check for end of segment
	if ck > maxx + 25 then
	    exit
	end if
	redX += 1
	ck += 1
	View.Update
	cls
    end loop
    % Speech
    drawline (0, 50, maxx, 50, black)
    drawbox (redX, 51, redX + 50, 101, brightred)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    drawoval (ck, 59, 8, 8, brightgreen)
    Font.Draw ("Wait!", 150, 255, font1, brightgreen)
    View.Update
    delay (2000)
    cls
    % Third segment
    loop
	drawline (0, 50, maxx, 50, black)
	drawbox (redX, 51, redX + 50, 101, brightred)
	drawbox (ssx, 51, ssx + 15, 66, brightgreen)
	drawoval (ck, 59, 8, 8, brightgreen)
	% Check for end of segment
	if ssx > maxx - 50 then
	    exit
	end if
	ssx += 1
	View.Update
	cls
    end loop
    % Increase level
    level += 1
end cutscene1
procedure level7
    Font.Draw ("Go after Dr.SquareMan", 100, maxy - 100, font1, blue)
    drawline (0, 50, maxx, 50, black)
    % Objective
    drawbox (800, 51, 850, 101, blue)
    % Triggers
    if playerX > 400 then
	textOn := true
    end if
    if textOn = true then
	% Trigger text, arrow and platforms.
	Font.Draw ("Hit that switch to keep going!", 50, 400, font1, blue)
	drawline (185, 275, 200, 350, blue)
	drawline (185, 275, 170, 290, blue)
	drawline (185, 275, 200, 290, blue)
	drawline (300, 150, 350, 150, black)
	drawline (150, 250, 250, 250, black)
	drawfillbox (175, 251, 225, 256, grey)
    end if
    % Switch trigger
    if playerX > 174 and playerX < 226 and playerY > 250 and playerY < 256 then
	switchGet := true
    end if
    if switchGet = false and textOn = true then
	% Switch plat
	Draw.ThickLine (600, maxy, 600, 63, 25, brightred)
    end if
    % Death check
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
	switchGet := false
    end if
    % Objective check
    if playerX > 799 and playerX < 851 and playerY > 50 and playerY < 102 then
	objectiveGet := true
    end if
end level7
procedure level8
    %Section1
    drawline (0, 50, maxx, 50, black)
    drawline (250, 50, 250, 600, brightred)
    drawline (0, 150, 25, 150, black)
    drawline (125, 200, 150, 200, black)
    Draw.ThickLine (225, 275, 250, 275, 2, black)
    Draw.ThickLine (225, 375, 250, 375, 2, black)
    drawline (112, 450, 137, 450, black)
    % Teleport set1
    drawbox (0, 500, 50, 550, purple)
    drawbox (350, 531, 400, 581, purple)
    if playerX > 0 and playerX < 50 and playerY > 500 and playerY < 550 then
	playerX := 355
	playerY := 536
	teleport1 := true
    end if
    %Section2
    drawline (500, 101, 500, 600, brightred)
    drawfillbox (251, 150, 260, 200, grey)
    drawline (250, 475, 360, 475, brightred)
    drawline (375, 385, 500, 385, brightred)
    drawline (250, 295, 365, 295, brightred)
    drawline (375, 205, 500, 205, brightred)
    Draw.ThickLine (248, 55, 550, 55, 2, black)
    % Switch trigger
    if playerX < 261 and playerX > 251 and playerY < 201 and playerY > 149 then
	switchGet := true
	playerX += 10
    end if
    % Switching plat
    if switchGet = false then
	Draw.ThickLine (500, 55, 500, 100, 10, brightred)
    end if
    %Section3
    Draw.ThickLine (575, 150, 600, 150, 2, black)
    Draw.ThickLine (655, 250, 690, 250, 2, black)
    Draw.ThickLine (745, 350, 780, 350, 2, black)
    Draw.ThickLine (835, 450, 870, 450, 2, black)
    Draw.ThickLine (555, 52, maxx, 52, 5, brightred)
    % Final plat and objective
    drawline (935, 525, 1000, 525, black)
    drawbox (949, 526, 999, 576, blue)
    % Death redraw
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
	switchGet := false
	teleport1 := false
	teleport2 := false
    end if
    % Objective check
    if playerX > 948 and playerX < 1000 and playerY > 525 and playerY < 577 then
	objectiveGet := true
    end if
end level8
procedure trapdoorCutscene
    var redX, ssx, ssy, font1, cageY : int
    cageY := 605
    redX := 750
    ssx := -50
    ssy := 51
    %Before Boss cutscene
    font1 := Font.New ("Comic Sans MS:18:bold")
    setscreen ("graphics:1000;600,offscreenonly")
    loop
	drawline (0, 50, 1000, 50, black)
	Draw.ThickLine (425, 50, 490, 50, 3, black)
	drawfillbox (994, 55, 999, 75, grey)
	drawbox (redX, 51, redX + 50, 101, brightred)
	drawbox (ssx, 51, ssx + 15, 66, brightgreen)
	if ssx not= 450 then
	    ssx += 1
	else
	    exit
	end if
	View.Update
	cls
    end loop
    Font.Draw ("STOP!", 730, 200, font1, brightred)
    View.Update
    delay (1500)
    cls
    drawline (0, 50, 1000, 50, black)
    Draw.ThickLine (425, 50, 490, 50, 3, black)
    drawfillbox (994, 55, 999, 75, grey)
    drawbox (redX, 51, redX + 50, 101, brightred)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    Font.Draw ("No! You took circle kid!", 350, 200, font1, brightgreen)
    View.Update
    delay (1500)
    cls
    drawline (0, 50, 1000, 50, black)
    Draw.ThickLine (425, 50, 490, 50, 3, black)
    drawfillbox (994, 55, 999, 75, grey)
    drawbox (redX, 51, redX + 50, 101, brightred)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    Font.Draw ("THEN YOU LEAVE ME NO CHOICE", 575, 200, font1, brightred)
    View.Update
    delay (1500)
    cls
    loop
	drawline (0, 50, 1000, 50, black)
	Draw.ThickLine (425, 50, 490, 50, 3, black)
	drawfillbox (994, 55, 999, 75, grey)
	drawbox (redX, 51, redX + 50, 101, brightred)
	drawbox (ssx, 51, ssx + 15, 66, brightgreen)
	if redX + 50 not= 993 then
	    redX += 1
	else
	    exit
	end if
	View.Update
	cls
    end loop
    loop
	Font.Draw ("HAHAHAHAHAHA!", 575, 200, font1, brightred)
	drawline (0, 50, 1000, 50, black)
	Draw.ThickLine (425, 50, 490, 50, 3, black)
	drawfillbox (994, 55, 999, 75, grey)
	drawbox (redX, 51, redX + 50, 101, brightred)
	drawbox (ssx, 51, ssx + 15, 66, brightgreen)
	drawbox (425, cageY, 490, cageY + 65, red)
	if cageY not= 50 then
	    cageY -= 1
	else
	    exit
	end if
	View.Update
	cls
    end loop
    loop
	Font.Draw ("NOOOOOOOOO!", 360, 200, font1, brightgreen)
	drawline (0, 50, 425, 50, black)
	drawline (490, 50, 1000, 50, black)
	Draw.ThickLine (425, 50, 425, 0, 3, black)
	drawfillbox (994, 55, 999, 75, grey)
	drawbox (redX, 51, redX + 50, 101, brightred)
	drawbox (ssx, ssy, ssx + 15, ssy + 15, brightgreen)
	drawbox (425, cageY, 490, cageY + 65, red)
	if cageY + 65 not= -10 then
	    ssy -= 1
	    cageY -= 1
	else
	    exit
	end if
	View.Update
	cls
    end loop
    objectiveGet := true
end trapdoorCutscene
procedure level9
    %Ground
    drawline (0, 50, 1000, 50, black)
    %Lava
    Draw.ThickLine (100, 50, 1000, 50, 5, brightred)
    %Bottom platforms
    drawline (0, 100, 30, 100, black)
    drawline (130, 100, 160, 100, black)
    drawline (260, 100, 290, 100, black)
    drawline (390, 100, 420, 100, black)
    drawline (520, 100, 550, 100, black)
    drawline (650, 100, 680, 100, black)
    drawline (780, 100, 810, 100, black)
    drawline (910, 100, 940, 100, black)
    drawline (969, 200, 999, 200, black)
    drawline (969, 250, 999, 250, black)
    %Death line bottom
    drawline (0, 265, 900, 265, brightred)
    %Moving platforms bottom and middle row
    Draw.ThickLine (195, movePlatY, 195, movePlatY + 110, 2, brightred)
    Draw.ThickLine (455, movePlatY, 455, movePlatY + 110, 2, brightred)
    Draw.ThickLine (715, movePlatY, 715, movePlatY + 110, 2, brightred)
    %Middle platforms
    Draw.ThickLine (0, 380, 30, 380, 2, black)
    Draw.ThickLine (0, 450, 30, 450, 2, black)
    Draw.ThickLine (0, 505, 30, 505, 2, black)
    drawline (130, 340, 160, 340, black)
    drawline (260, 340, 290, 340, black)
    drawline (390, 340, 420, 340, black)
    drawline (520, 340, 550, 340, black)
    drawline (650, 340, 680, 340, black)
    drawline (780, 340, 810, 340, black)
    drawline (910, 340, 940, 340, black)
    %Death line middle
    drawline (100, 465, 1000, 465, brightred)
    %Moving platforms middle and top row
    Draw.ThickLine (325, movePlatY + 200, 325, movePlatY + 330, 2, brightred)
    Draw.ThickLine (585, movePlatY + 200, 585, movePlatY + 330, 2, brightred)
    Draw.ThickLine (845, movePlatY + 200, 845, movePlatY + 330, 2, brightred)
    %Top platforms
    drawline (130, 555, 160, 535, black)
    drawline (260, 555, 290, 535, black)
    drawline (390, 555, 420, 535, black)
    drawline (520, 555, 550, 535, black)
    drawline (650, 555, 680, 535, black)
    drawline (780, 555, 810, 535, black)
    %Objective
    drawbox (905, 525, 935, 575, blue)
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
	switchGet := false
	teleport1 := false
	teleport2 := false
	movePlatX := 70
	movePlatY := 200
	platBack := false
    end if
    if movePlatY > 350 then
	platBack := true
    end if
    if platBack = true and movePlatY < 100 then
	platBack := false
    end if
    if platBack = true then
	movePlatY -= 1
    elsif platBack = false then
	movePlatY += 1
    end if
    % Objective check
    if playerX > 904 and playerX < 936 and playerY > 524 and playerY < 576 then
	objectiveGet := true
    end if
end level9
procedure level10
    %ground
    Draw.ThickLine (0, 50, 1000, 50, 2, black)
    %Death Lines
    Draw.ThickLine (275, 50, 275, 600, 10, brightred)
    Draw.ThickLine (555, 600, 555, 240, 10, brightred)
    Draw.ThickLine (875, 50, 875, 500, 10, brightred)
    Draw.ThickLine (275, 50, 875, 50, 5, brightred)
    %1st Section
    %Platforms Left Side
    Draw.ThickLine (0, 125, 20, 125, 2, black)
    Draw.ThickLine (250, 245, 270, 245, 2, black)
    Draw.ThickLine (0, 355, 20, 355, 2, black)
    Draw.ThickLine (250, 475, 270, 475, 2, black)
    %Move between 70 and 180
    Draw.ThickLine (movePlatX, 180, movePlatX + 30, 180, 2, black)
    %Move between 180 and 70
    Draw.ThickLine (movePlatX, 300, movePlatX + 30, 300, 2, black)
    %Move between 70 and 180
    Draw.ThickLine (movePlatX, 410, movePlatX + 30, 410, 2, black)
    %Move between 180 and 70
    Draw.ThickLine (movePlatX, 530, movePlatX + 30, 530, 2, black)
    %Teleporter
    drawbox (1, 549, 51, 599, purple)
    %2nd Section
    %Tele exit
    drawbox (499, 549, 549, 599, purple)
    % Teleport trigger
    if playerX >= 1 and playerX < 52 and playerY > 548 and playerY < 600 then
	playerX := 520
	playerY := 565
	teleport1 := true
    end if
    %Death Lines
    Draw.ThickLine (445, 475, 555, 475, 2, brightred)
    Draw.ThickLine (275, 390, 425, 390, 2, brightred)
    Draw.ThickLine (425, 305, 555, 305, 2, brightred)
    %Slants
    Draw.ThickLine (280, 205, 325, 170, 2, black)
    Draw.ThickLine (380, 155, 425, 120, 2, black)
    Draw.ThickLine (480, 105, 525, 70, 2, black)
    %Platforms
    Draw.ThickLine (600, 115, 620, 115, 2, black)
    Draw.ThickLine (680, 175, 700, 175, 2, black)
    Draw.ThickLine (760, 235, 780, 235, 2, black)
    Draw.ThickLine (850, 275, 870, 275, 2, black)
    Draw.ThickLine (600, 445, 620, 445, 2, black)
    Draw.ThickLine (680, 385, 700, 385, 2, black)
    Draw.ThickLine (760, 325, 780, 325, 2, black)
    Draw.ThickLine (560, 495, 580, 495, 2, black)
    Draw.ThickLine (630, 535, 650, 535, 2, black)
    Draw.ThickLine (720, 565, 740, 565, 2, black)
    Draw.ThickLine (810, 535, 830, 535, 2, black)
    %3rd Section
    %Death Lines
    Draw.ThickLine (880, 470, 935, 470, 2, brightred)
    Draw.ThickLine (935, 385, 1000, 385, 2, brightred)
    Draw.ThickLine (880, 300, 935, 300, 2, brightred)
    Draw.ThickLine (935, 215, 1000, 215, 2, brightred)
    %Objective
    drawbox (949, 51, 999, 101, blue)
    % Death redraw
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
	switchGet := false
	teleport1 := false
	teleport2 := false
	movePlatX := 70
	platBack := false
    end if
    % Objective check
    if playerX > 948 and playerX < 1000 and playerY > 50 and playerY < 102 then
	objectiveGet := true
    end if
    if movePlatX + 20 >= 200 then
	platBack := false
    elsif movePlatX <= 0 then
	platBack := true
    end if
    % Platform reverse direction
    if platBack = true then
	movePlatX += 1
    end if
    if movePlatX = 0 then
	platBack := false
    end if
    if platBack = false then
	movePlatX -= 1
    end if
    % Check if on plat
    if playerY - 1 = 300 or playerY - 1 = 180 or playerY - 1 = 410 or playerY - 1 = 530 or playerY - 1 = 200 or playerY - 1 = 410 then
	if playerX > movePlatX and playerX < movePlatX + 30 then
	    onPlat := true
	else
	    onPlat := false
	end if
    else
	onPlat := false
    end if
    % Alter player velocity
    if onPlat = true and platBack = false then
	velocityX -= 1
    elsif onPlat = true and platBack = true then
	velocityX += 1
    end if
end level10
procedure bossInstructions
    cls
    % Super Square Boy
    drawbox (50, 51, 75, 76, brightgreen)
    % Ground
    drawline (0, 50, maxx, 50, black)
    % Platforms
    drawline (500, 600, 500, 550, black)
    drawbox (450, 450, 550, 550, black)
    drawoval (500, 459, 8, 8, brightgreen)
    drawline (475, 550, 475, 450, black)
    drawline (500, 550, 500, 450, black)
    drawline (525, 550, 525, 450, black)
    %Platforms Left Side
    drawline (0, 150, 50, 150, black)
    drawline (100, 250, 150, 250, black)
    drawline (0, 350, 50, 350, black)
    drawline (100, 450, 150, 450, black)
    % Left switch
    drawfillbox (0, 550, 5, 500, grey)
    %Platforms Right Side
    drawline (950, 150, 1000, 150, black)
    drawline (900, 250, 850, 250, black)
    drawline (950, 350, 1000, 350, black)
    drawline (900, 450, 850, 450, black)
    %Switch Right Side
    drawfillbox (999, 550, 994, 500, grey)
    %Final Platforms
    drawline (300, 515, 300, 600, black)
    drawline (700, 515, 700, 600, black)
    Draw.ThickLine (250, 515, 350, 515, 2, black)
    Draw.ThickLine (750, 515, 650, 515, 2, black)
    %Death Line
    Draw.ThickLine (200, 50, 800, 50, 5, brightred)
    Font.Draw ("Square Boy!  I'm up here!", 350, 280, font1, brightgreen)
    View.Update
    delay (1000)
    Font.Draw ("Dr.SquareMan is coming back.", 300, 200, font1, brightgreen)
    View.Update
    delay (3000)
    Text.Cls
    View.Update
    delay (800)
    Font.Draw ("You need to hit the switches to damage him!", 200, 400, font1, brightgreen)
    View.Update
    delay (800)
    Font.Draw ("He's coming... don't worry about me, I'll be fine!", 150, 300, font1, brightgreen)
    View.Update
    delay (4000)
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
	switchGet := false
	teleport1 := false
	teleport2 := false
	movePlatX := 70
	platBack := false
    end if
    % Objective check
    level += 1
end bossInstructions
procedure boss
    % Ground
    drawline (0, 50, maxx, 50, black)
    % Health Bar
    Font.Draw ("Boss Health: ", maxx - 350, 7, font1, black)
    drawbox (maxx - 1, 2, maxx - 153, 45, black)
    drawfillbox (maxx - 2, 3, maxx - 2 - 50 * bossHealth, 44, brightred)
    %Cage
    if bossKill = false then
	drawline (500, 600, 500, 550, black)
	drawbox (450, 450, 550, 550, black)
	drawoval (500, 459, 8, 8, brightgreen)
	drawline (475, 550, 475, 450, black)
	drawline (500, 550, 500, 450, black)
	drawline (525, 550, 525, 450, black)
	% Cage falling
    elsif cageFall <= 350 then
	drawbox (450, 450 - cageFall, 550, 550 - cageFall, black)
	drawoval (500, 459 - cageFall, 8, 8, brightgreen)
	drawline (475, 550 - cageFall, 475, 450 - cageFall, black)
	drawline (500, 550 - cageFall, 500, 450 - cageFall, black)
	drawline (525, 550 - cageFall, 525, 450 - cageFall, black)
	cageFall += 2
    else
	bossDead := true
    end if
    %Platforms Left Side
    drawline (0, 150, 50, 150, black)
    drawline (100, 250, 150, 250, black)
    drawline (0, 350, 50, 350, black)
    drawline (100, 450, 150, 450, black)
    % Boss growth
    if bossHealth = 3 then
	DSGx := 350 - DSGinc
	DSGy := 51
	DSGBigx := DSGx + 50 + DSGinc * 2
	DSGBigy := DSGy + 50 + DSGinc * 2
	Draw.ThickLine (DSGx, DSGBigy, DSGBigx, DSGBigy, 2, brightred)
	drawbox (DSGx, DSGy, DSGBigx, DSGBigy, brightred)
    end if
    if bossHealth = 1 then
	DSGinc := 0
	health1Count += 1
	if health1Count >= 10 then
	    bossAttack := true
	    count4 += 1
	    count5 += 1
	    DSGx := maxx div 2 - 25
	    DSGBigy := 105
	    DSGBigx := DSGx + 50
	    Draw.ThickLine (DSGx, DSGBigy, DSGBigx, DSGBigy, 2, brightred)
	    drawbox (DSGx, DSGy, DSGBigx, DSGBigy, brightred)
	end if
    end if
    if bossHealth = 2 then
	DSGx := 500
	DSGy := 51
	DSGBigx := DSGx + 50 + DSGinc * 2
	DSGBigy := DSGy + 50 + DSGinc * 2
	drawbox (DSGx, DSGy, DSGBigx, DSGBigy, brightred)
    end if
    if count3 >= 2 then
	DSGinc += 1
	count3 := 0
    end if
    count3 += 1
    %Switch Left Side
    if switchGet = false then
	drawfillbox (0, 550, 5, 500, grey)
    end if
    % Switch trigger
    if playerX < 6 and playerX > -1 and playerY < 551 and playerY > 499 then
	if switchGet = false then
	    bossHealth -= 1
	    DSGinc := 0
	end if
	switchGet := true
	playerX += 10
	playerX := 900
	playerY := 55
    end if
    if switchGet = true then
	drawbox (875, 51, 925, 101, purple)
    end if
    % Boss attack
    if bossAttack = true and count5 > 20 and bossKill = false then
	if laserY < 600 then
	    Draw.ThickLine ((DSGBigx + DSGx) div 2, DSGy, laserX, laserY, 2, brightred)
	end if
	if laserY2 < 600 then
	    Draw.ThickLine (laserX2, laserY2, (DSGBigx + DSGx) div 2, DSGy, 2, brightred)
	else
	    laserTop := true
	    laserX := 0
	    laserX2 := 1000
	end if
	% Lasers close in
	if laserTop = true then
	    % Random laser
	    if count4 mod 40 = 0 then
		randint (laserVariant, -100, 100)
	    end if
	    Draw.ThickLine (laserX, laserY, (DSGBigx + DSGx) div 2, DSGy, 2, brightred)
	    Draw.ThickLine (laserX2, laserY2, (DSGBigx + DSGx) div 2, DSGy, 2, brightred)
	    Draw.ThickLine (maxx div 2 + laserVariant, 800, maxx div 2, 55, 10, brightred)
	end if
	% Laser close in together
	if laserTop = true and bossKill = false then
	    laserX += 200
	    laserX2 -= 200
	    laserY += 1
	    laserY2 += 1
	end if
	% Laser Speed up
	if playerY < 200 then
	    if count4 mod 2 = 0 then
		laserY2 += 1
		laserY += 1
	    end if
	elsif playerY < 300 then
	    laserY2 += 1
	    laserY += 1
	else
	    laserY2 += 2
	    laserY += 2
	end if
    end if
    %Platforms Right Side
    drawline (950, 150, 1000, 150, black)
    drawline (900, 250, 850, 250, black)
    drawline (950, 350, 1000, 350, black)
    drawline (900, 450, 850, 450, black)
    %Switch Right Side
    if switchGet2 = false then
	drawfillbox (999, 550, 994, 500, grey)
    end if
    % Switch trigger
    if playerXBig > 994 and playerXBig < 1000 and playerYBig > 499 and playerYBig < 551 then
	if switchGet2 = false then
	    bossHealth -= 1
	    DSGinc := 0
	end if
	switchGet2 := true
	playerX -= 10
	playerX := 100
	playerY := 55
    end if
    if switchGet2 = true then
	drawbox (75, 55, 125, 101, purple)
    end if
    %Final Platforms
    drawline (300, 515, 300, 600, black)
    drawline (700, 515, 700, 600, black)
    Draw.ThickLine (250, 515, 350, 515, 2, black)
    Draw.ThickLine (750, 515, 650, 515, 2, black)
    %Death Line
    Draw.ThickLine (200, 50, 800, 50, 5, brightred)
    % Check for boss dead
    if bossHealth = 1 and playerXBig > 450 and playerX < 550 and playerY > 550 and playerY < 555 then
	bossKill := true
    end if
    % Death redraw
    if count2 = 0 or die = true then
	playerX := 50
	playerY := 51
	count2 := 1
	die := false
	switchGet := false
	teleport1 := false
	teleport2 := false
	switchGet2 := false
	bossHealth := 3
	DSGinc := 0
	bossAttack := false
	bossAttackTrigger := false
	count4 := 0
	laserY := 215
	laserY2 := 0
	laserX := 0
	laserX2 := 0
	count5 := 0
	laserTop := false
	laserBack := false
	laserVariant := 0
    end if
    % Check if boss is dead
    if bossDead = true then
	objectiveGet := true
    end if
end boss
procedure finalCut
    var redX, redX2, redY2, redY, ssx, ck, font1 : int
    redX := 475
    redY := 53
    redY2 := 103
    redX2 := redX + 50
    ssx := 250
    ck := 285
    font1 := Font.New ("Comic Sans MS:18:bold")
    % Draw beginning positions
    drawline (0, 50, maxx, 50, black)
    Draw.ThickLine (430, 50, 1000, 50, 5, brightred)
    drawbox (redX, redY, redX2, redY2, red)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    drawoval (ck, 59, 8, 8, brightgreen)
    % Boss text
    Font.Draw ("YOU WILL RUE THE DAY YOU DEFEATED ME SQUARE BOY!", 200, 355, font1, red)
    View.Update
    delay (2000)
    % Boss shrinks
    loop
	Font.Draw ("NOOOOOOO!", 350, 355, font1, red)
	drawline (0, 50, maxx, 50, black)
	Draw.ThickLine (430, 50, 1000, 50, 5, brightred)
	drawbox (redX, redY, redX2, redY2, red)
	drawbox (ssx, 51, ssx + 15, 66, brightgreen)
	drawoval (ck, 59, 8, 8, brightgreen)
	redY2 -= 1
	redX2 -= 1
	if redY2 = 53 then
	    exit
	end if
	delay (50)
	View.Update
	cls
    end loop
    cls
    % Redraw everything
    drawline (0, 50, maxx, 50, black)
    Draw.ThickLine (430, 50, 1000, 50, 5, brightred)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    drawoval (ck, 59, 8, 8, brightgreen)
    % Circle boy text
    Font.Draw ("Thanks for saving me square boy!", 200, 300, font1, brightgreen)
    View.Update
    delay (2000)
    cls
    drawline (0, 50, maxx, 50, black)
    Draw.ThickLine (430, 50, 1000, 50, 5, brightred)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    drawoval (ck, 59, 8, 8, brightgreen)
    % Square Boy text
    Font.Draw ("No problem! But we have to get out of here.", 200, 300, font1, brightgreen)
    View.Update
    delay (2000)
    cls
    drawline (0, 50, maxx, 50, black)
    Draw.ThickLine (430, 50, 1000, 50, 5, brightred)
    drawbox (ssx, 51, ssx + 15, 66, brightgreen)
    drawoval (ck, 59, 8, 8, brightgreen)
    % Circle boy text
    Font.Draw ("Okay.", 200, 300, font1, brightgreen)
    View.Update
    delay (2000)
    cls
    % Move off screen
    loop
	drawline (0, 50, maxx, 50, black)
	Draw.ThickLine (430, 50, 1000, 50, 5, brightred)
	drawbox (ssx, 51, ssx + 15, 66, brightgreen)
	drawoval (ck, 59, 8, 8, brightgreen)
	ck -= 1
	ssx -= 1
	if ssx + 50 = 0 then
	    exit
	end if
	View.Update
	cls
    end loop
    level += 1
end finalCut
procedure game
    % Game
    loop
	% Start movement
	if level not= 1 then
	    movement
	end if
	% Level change
	if level = 1 then
	    cutsceneStart
	elsif level = 2 then
	    level1
	elsif level = 3 then
	    level2
	elsif level = 4 then
	    level3
	elsif level = 5 then
	    level4
	elsif level = 6 then
	    level5
	elsif level = 7 then
	    level6
	elsif level = 8 then
	    cutscene1
	elsif level = 9 then
	    level7
	elsif level = 10 then
	    level8
	elsif level = 11 then
	    trapdoorCutscene
	elsif level = 12 then
	    level9
	elsif level = 13 then
	    level10
	elsif level = 14 then
	    bossInstructions
	elsif level = 15 then
	    boss
	elsif level = 16 then
	    finalCut
	elsif level = 17 then
	    win := true
	end if

	    exit when win = true
	% Level change and reset variables
	if objectiveGet = true then
	    level += 1
	    objectiveGet := false
	    count2 := 0
	    textOn := false
	    checkpoint := 0
	    switchGet := false
	    teleport1 := false
	    teleport2 := false
	    switchGet2 := false
	    cls
	end if
    end loop
end game
var font7, font8, font3, font4, mouseX, mouseY, button : int
font7 := Font.New ("Comic Sans MS:50:bold")
font8 := Font.New ("Comic Sans MS:18:bold,italic")
font3 := Font.New ("Comic Sans MS:15:bold,italic")
font4 := Font.New ("Comic Sans MS:14:bold")
setscreen ("graphics:1000;600,offscreenonly,nocursor,nobuttonbar")
procedure ssbbio
    %Title
    Font.Draw ("SUPER SQUARE BOY", 25, 535, font7, brightgreen)
    %Character
    drawbox (25, 100, 325, 400, black)
    drawbox (168, 242, 184, 258, brightgreen)
    %Bio
    Font.Draw ("He is the most interesting square in the world.  When he was 4,", 375, 380, font4, brightgreen)
    Font.Draw ("he stopped the triangles from taking over Square Town, and ever", 375, 350, font4, brightgreen)
    Font.Draw ("since, has declared all things evil an enemy.  His best friend,", 375, 320, font4, brightgreen)
    Font.Draw ("Circle Kid, is regularly getting himself into trouble, and Super", 375, 290, font4, brightgreen)
    Font.Draw ("Square Boy has had to save him time and time again, but he has", 375, 260, font4, brightgreen)
    Font.Draw ("never gone up against anything as terrifyingly evil as Dr. Square", 375, 230, font4, brightgreen)
    Font.Draw ("Man.", 375, 200, font4, brightgreen)
    %Back
    Font.Draw ("(Press any key to continue)", 550, 120, font4, brightgreen)
    View.Update
    Input.Pause
end ssbbio
procedure dsmbio
    %Title
    Font.Draw ("DR. SQUARE MAN", 25, 535, font7, brightred)
    %Character
    drawbox (25, 100, 325, 400, black)
    drawbox (150, 225, 200, 275, brightred)
    %Bio
    Font.Draw ("Rejected by his mother, and cast out by his father, he went", 375, 380, font4, brightred)
    Font.Draw ("to study at evil medical school and finished second in the class,", 375, 350, font4, brightred)
    Font.Draw ("only after the infamous Dr. Evil.  He only knows how to do two", 375, 320, font4, brightred)
    Font.Draw ("things, to destroy everything good, and to chew bubble gum. And", 375, 290, font4, brightred)
    Font.Draw ("he's all out of bubble gum.", 375, 260, font4, brightred)
    %Back
    Font.Draw ("(Press any key to continue)", 550, 120, font4, brightred)
    View.Update
    Input.Pause
end dsmbio
procedure ckbio
    %Title
    Font.Draw ("CIRCLE KID", 25, 535, font7, brightgreen)
    %Character
    drawbox (25, 100, 325, 400, black)
    drawoval (175, 258, 8, 8, brightgreen)
    %Bio
    Font.Draw ("Super Square Boy's best friend, he is repeatedly getting himself", 375, 380, font4, brightgreen)
    Font.Draw ("trouble needing Super Square Boy's rescue, but unlike many other", 375, 350, font4, brightgreen)
    Font.Draw ("superhero's best friends, he doesn't seem to mind at all about", 375, 320, font4, brightgreen)
    Font.Draw ("not having amazing jumping abilities.", 375, 290, font4, brightgreen)
    %Back
    Font.Draw ("(Press any key to continue)", 550, 120, font4, brightgreen)
    View.Update
    Input.Pause
end ckbio
procedure bios
    loop
	View.Update
	% Bio selection screen
	%Character bios
	Font.Draw ("CHARACTER BIOS", 200, 535, font7, brightgreen)
	%SB
	drawfillbox (70, 285, 270, 345, black)
	Font.Draw ("Super Square Boy", 80, 310, font3, brightgreen)
	%SM
	drawfillbox (370, 285, 570, 345, black)
	Font.Draw ("Dr. Square Man", 390, 310, font3, brightred)
	%CK..
	drawfillbox (670, 285, 870, 345, black)
	Font.Draw ("Circle Kid", 720, 310, font3, brightgreen)
	%Back
	drawfillbox (410, 105, 530, 165, black)
	Font.Draw ("Back", 440, 130, font8, brightgreen)
	View.Update
	delay (800)
	% Bio selection
	loop
	    Mouse.Where (mouseX, mouseY, button)
	    if mouseX >= 70 and mouseX <= 270 and mouseY >= 285 and mouseY <= 345 and button not= 0 then
		cls
		ssbbio
		cls
		exit
	    elsif mouseX >= 370 and mouseX <= 570 and mouseY >= 285 and mouseY <= 345 and button not= 0 then
		cls
		dsmbio
		cls
		exit
	    elsif mouseX >= 670 and mouseX <= 870 and mouseY >= 285 and mouseY <= 345 and button not= 0 then
		cls
		ckbio
		cls
		exit
	    elsif mouseX >= 410 and mouseX <= 530 and mouseY >= 105 and mouseY <= 165 and button not= 0 then
		cls
		back := true
		exit
	    end if
	end loop
	exit when back = true
    end loop
end bios

procedure menu
    back := false
    var font1, font2, font3, mouseX, mouseY, button : int
    font1 := Font.New ("Comic Sans MS:50:bold")
    font2 := Font.New ("Comic Sans MS:18:bold,italic")
    font3 := Font.New ("Comic Sans MS:15:bold,italic")
    setscreen ("graphics:1000;600,offscreenonly")
    %Menu
    %Title
    Font.Draw ("Super Square Boy!", 65, 500, font1, brightgreen)
    Font.Draw ("And Circle Kid!", 65, 465, font2, brightgreen)
    %Play Box
    drawfillbox (725, 350, 885, 400, black)
    Font.Draw ("PLAY", 769, 365, font2, brightgreen)
    %Instruction Box
    drawfillbox (725, 275, 885, 325, black)
    Font.Draw ("INSRUCTIONS", 728, 295, font3, brightgreen)
    %Quit Box
    drawfillbox (725, 200, 885, 250, black)
    Font.Draw ("QUIT", 769, 215, font2, brightgreen)
    %People Box
    drawfillbox (150, 300, 315, 350, black)
    Font.Draw ("CHARACTERS", 163, 320, font3, brightgreen)
    % Square boy
    % Cape
    drawline (750, 550, 700, 475, brightred) 
    drawline (700, 475, 720, 460, brightred)
    drawline (720, 460, 750, 510, brightred)
    % Character
    Font.Draw ("S", 707, 475, font8, brightgreen)
    %drawbox (721, 495, 739, 513, brightgreen)
    drawbox (750, 475, 825, 550, brightgreen)
    % Circle kid
    drawoval (285, 150, 25, 25, brightgreen)
    % DSM
    drawbox (315, 125, 415, 225, brightred)
    View.Update
    loop
	Mouse.Where (mouseX, mouseY, button)
	if mouseX <= 315 and mouseX >= 150 and mouseY >= 300 and mouseY <= 350 and button not= 0 then
	    cls
	    bios
	    cls
	    exit
	elsif mouseX >= 725 and mouseX <= 885 and mouseY <= 250 and mouseY >= 200 and button not= 0 then
	    quit
	elsif mouseX >= 725 and mouseX <= 885 and mouseY >= 275 and mouseY <= 325 and button not= 0 then
	    cls
	    var font9, font10 : int
	    font7 := Font.New ("Comic Sans MS:50:bold")
	    font10 := Font.New ("Comic Sans MS:24:bold")
	    font8 := Font.New ("Comic Sans MS:18:bold,italic")
	    font9 := Font.New ("Comic Sans MS:18")
	    font3 := Font.New ("Comic Sans MS:15:bold,italic")
	    font4 := Font.New ("Comic Sans MS:14:bold")
	    setscreen ("graphics:1000;600,offscreenonly,nobuttonbar,nocursor")
	    %Instructions
	    %Title
	    Font.Draw ("Instructions", 25, 535, font7, brightgreen)
	    %Instructions slide 1
	    Font.Draw ("Basic Platforming", 33, 390, font10, brightgreen)
	    Font.Draw ("To move Super Square Boy you need to utilize the directional arrow keys.", 55, 330, font9, brightgreen)
	    Font.Draw ("The left and right arrow keys will move Super Square Boy left and right,", 55, 280, font9, brightgreen)
	    Font.Draw ("and pressing the up arrow key will make Super Square Boy jump.", 55, 230, font9, brightgreen)
	    Font.Draw ("(Press any key to continue)", 350, 120, font4, brightgreen)
	    View.Update
	    Input.Pause
	    cls
	    %Title
	    Font.Draw ("Instructions", 25, 535, font7, brightgreen)
	    %Instructions slide 2
	    Font.Draw ("Navigation", 33, 390, font10, brightgreen)
	    Font.Draw ("To navigate each level, you need to navigate a variety of platforms and obstacles.", 35, 330, font9, brightgreen)
	    Font.Draw ("Anything that is coloured bright red is evil, and will reset the entire level if you", 35, 290, font9, brightgreen)
	    Font.Draw ("touch it.  To reach the end of the level you need to jump on the platforms and reach", 35, 250, font9, brightgreen)
	    Font.Draw ("the blue box.", 35, 210, font9, brightgreen)
	    Font.Draw ("(Press any key to continue)", 350, 120, font4, brightgreen)
	    % Pics
	    drawbox (900, 50, 950, 100, blue)
	    drawline (800, 500, 900, 500, black)
	    drawbox (825, 501, 850, 525, brightgreen)
	    drawline (50, 100, 150, 100, brightred)
	    Font.Draw ("EVIL!", 5, 110, font3, brightred)
	    View.Update
	    Input.Pause
	    cls
	    %Title
	    Font.Draw ("Instructions", 25, 535, font7, brightgreen)
	    %Instructions slide 3
	    Font.Draw ("Advanced", 33, 390, font10, brightgreen)
	    Font.Draw ("Purple boxes are teleporters and will teleport you to the matching purple box in the", 35, 330, font9, brightgreen)
	    Font.Draw ("level.  Grey boxes are switches and will remove obstacles in the level such as red", 35, 290, font9, brightgreen)
	    Font.Draw ("doors.", 35, 250, font9, brightgreen)
	    Font.Draw ("(Press any key to return to menu)", 320, 120, font4, brightgreen)
	    % Pics
	    drawbox (900, 100, 950, 150, purple)
	    drawline (904, 101, 904, 126, brightgreen)
	    drawline (904, 126, 919, 126, brightgreen)
	    drawline (904, 101, 919, 101, brightgreen)
	    drawbox (900, 500, 950, 550, purple)
	    drawline (929, 501, 929, 526, brightgreen)
	    drawline (929, 526, 915, 526, brightgreen)
	    drawline (929, 501, 915, 501, brightgreen)
	    drawfillbox (550, 260, 600, 270, grey)
	    drawline (500, 259, 650, 259, black)
	    View.Update
	    Input.Pause
	    cls
	    exit
	elsif mouseX >= 725 and mouseX <= 885 and mouseY >= 350 and mouseY <= 400 and button not= 0 then
	    cls
	    game
	    level := 1
	    win := false
	    bossDead := false
	    bossKill := false
	    cls
	    exit
	end if
    end loop
end menu
% Program Main
loop
    menu
    View.Update
    cls
end loop
