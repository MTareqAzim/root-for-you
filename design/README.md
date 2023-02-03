# Game Design
You control a group of fans who cheer on the main *player* of the game. Your cheers help the *player* achieve their goals. But cheering can also cause them to fail or make them angry if you cheer too much.

Rhythm game. You are told the things the opponent will do. You need to relay it to the *player* with your cheers. You can start your cheers at any time, but once you start, you need to follow the rhythm based off of the opponent's pattern.

## Platform
The game is aimed for Web mostly, but should also be built to target Android.

## Aesthetics
It's a 2D game. Minimal words outside of the instructions maybe. Cheers should be represented by icons that give a hint to what they do. Colorful and using transforms to make things big and exciting. Not much flashing colors.

The look is in a theater. You, the fans, are watching a play and are helping the *player* to beat his opponent.

4 colors for cheers. 2 colors for player and opponent. The fans can be shades of gray/monocolor.

## Accessibility
The player can change the colors used in the settings menu. The palettes should be preset. Hopefully, there are enough palettes that cater to every kind of color blindness.

## Sound Design
Lots of random cheering noises. Probably can record them myself. Maybe some frustrated noises for the *player* as well as some celebratory noises for when the player completes their goal.

Music should be calm and background. Not the main focus of the game. Softer than the others. Metronome sounds.

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
The *player* is not really you. You influence the *player* by cheering them on. The current goal of the *player* is to beat their opponent.

The *player* doesn't know what their opponent will do. The player does what you, the fans, cheer them to do. The player will execute the actions in the same rhythm you did the cheer in. Make sure you match the rhythm.

### Angry *Player*
On the back burner for now.

The *player* enters the angry state by starting a tantrum and changing color to easily indicate to the fans that they're angry. During the tantrum, the fans are unable to cheer. When the initial tantrum is over, the *player* starts acting randomly. The *player* can end up losing progress because of this. During this time, the fans cheer to calm the *player* down not control him. When the player has finally calmed down, they enter back into the regular state, but starts with a breathing session and changes back to their regular color. This indicates that they have calmed down and are directed by your cheers again. During the breathing session, you are unable to cheer.

What the *player* does in the angry state is...

## Fans
You play as the fans. Your influence on the *player*, and the whole game basically, is your cheers. You have certain cheers that make the *player* behave in a certain way. Cheer too much and you might make the *player* mad. When they're mad, they might not do anything, or might do something to spite you.

## Cheers
The aim is to have about 4 cheers. Each cheer is mapped to a different face button (A, B, X, Y) or to a different corner of the screen for mobile. On web it is mapped to keyboard buttons, but which buttons is not determined.