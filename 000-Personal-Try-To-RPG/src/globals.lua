gDirectionToYSpeed = {
	[1] = 1,
	[2] = -1,
	[3] = 0,
	[4] = 0
}

gDirectionToXSpeed = {
	[1] = 0,
	[2] = 0,
	[3] = 1,
	[4] = -1
}

gButtonToDirection = {
	['down'] = 1,
	['up'] = 2,
	['right'] = 3,
	['left'] = 4
}

gPlayerOutfits = {
	[1] = 'assets/character/01-outfit/char_a_p1_1out_boxr_v01.png',
	[2] = 'assets/charater/01-outfit/char_a_p1_1out_fstr_v04.png',
	[3] = 'assets/charater/01-outfit/char_a_p1_1out_pfpn_v04.png',
	[4] = 'assets/charater/01-outfit/char_a_p1_1out_undi_v01.png'
}

gPlayerCurrentOutfit = 0

gPlayerSheet = Sheet('assets/character/char_1.png', PLAYER_WIDTH, PLAYER_HEIGHT, 4, 4)

gPlayerModel = Model(gPlayerSheet)

gPlayerOutfit = Sheet(gPlayerOutfits[1], PLAYER_WIDTH, PLAYER_HEIGHT, 4, 4)

gPlayerModel:append(gPlayerOutfit)

gPlayerCharacter = Character(gPlayerModel)

gMenuFont = love.graphics.newFont('assets/Roboto-Medium.ttf', 20)
