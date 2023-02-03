# Game Design
You control a group of fans who cheer on the main *player* of the game. Your cheers help the *player* achieve their goals. But cheering can also cause them to fail or make them angry if you cheer too much.

## Platform
The game is aimed for Web mostly, but should also be built to target Android.

## Aesthetics
It's a 2D game. Minimal words outside of the instructions maybe. Cheers should be represented by icons that give a hint to what they do. Colorful and using transforms to make things big and exciting. Not much flashing colors.

*Player* should change colors when they are in the mad state. Maybe the cheers get locked for a moment, then switch to a different set to make the *player* less mad.

4 or 8 colors for cheers. 2 colors for player. The fans can be shades of gray/monocolor.

## Accessibility
The player can change the colors used in the settings menu. The palettes should be preset. Hopefully, there are enough palettes that cater to every kind of color blindness.

## Sound Design
Lots of random cheering noises. Probably can record them myself. Maybe some frustrated noises for the *player* as well as some celebratory noises for when the player completes their goal.

Music should be calm and background. Not the main focus of the game. Softer than the others.

## Menu Screen
Have a Play, Settings, maybe Credits, and an Exit (for PC).

## Settings
- Color Palette
- Button Layout
- Volume
    - Master
    - Cheer
    - *Player*
    - Music

## Button Layout
![Button layout for the main game scene. Corner layout where buttons are in each corner. Trigger layout where buttons are in top corners, staggered like triggers. Face button layout where buttons are top corners, but staggered like face buttons. All layouts should target to accomodate for a 16:9 aspect ratio.](button_layout.jpeg)

## *Player* and Their Game
The *player* is not really you. You influence the *player* by cheering them on. The current goal of the *player* is unknown.

The game the *player* plays is...

### Regular *Player*
During this period, the fans' cheers influence what the player does. Too many cheers at once confuses the *player* and makes them angry though. When that happens, the *player* goes into the angry state.

What the *player* can be cheered to do is...

What the *player* does when there are no cheers is...

### Angry *Player*
The *player* enters the angry state by starting a tantrum and changing color to easily indicate to the fans that they're angry. During the tantrum, the fans are unable to cheer. When the initial tantrum is over, the *player* starts acting randomly. The *player* can end up losing progress because of this. During this time, the fans cheer to calm the *player* down not control him. When the player has finally calmed down, they enter back into the regular state, but starts with a breathing session and changes back to their regular color. This indicates that they have calmed down and are directed by your cheers again. During the breathing session, you are unable to cheer.

What the *player* does in the angry state is...

## Fans
You play as the fans. Your influence on the *player*, and the whole game basically, is your cheers. You have certain cheers that make the *player* behave in a certain way. Cheer too much and you might make the *player* mad. When they're mad, they might not do anything, or might do something to spite you.

## Cheers
The aim is to have about 4 cheers. Each cheer is mapped to a different face button (A, B, X, Y) or to a different corner of the screen for mobile. On web it is mapped to keyboard buttons, but which buttons is not determined.