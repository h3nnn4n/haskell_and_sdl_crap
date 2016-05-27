module Main where

import Data
import Graphics

import Graphics.UI.SDL     as SDL
import Control.Monad
import System.IO.Unsafe

main :: IO ()
main = do
    SDL.init [InitEverything]

    setCaption "HATRIS" ""
    setVideoMode screenx screeny 24 [HWSurface, DoubleBuf]
    surface <- getVideoSurface

    game <- gameLoop surface newWorld

    SDL.quit

gameLoop :: Surface -> World -> IO World
gameLoop surface world = do
    event <- pollEvent
    case eventHandler event world of
        w@(World { toquit = True  }) -> return w
        w@(World { toquit = False }) -> do
            drawGrid surface
            drawPos  surface $ position w
            when (updateScrn w) (
                print $ position w )
            SDL.flip surface
            gameLoop surface w { updateScrn = False }

eventHandler :: Event -> World -> World
eventHandler event world =
    case event of
        KeyDown (Keysym key _ _) -> case key of
            SDLK_DOWN   -> world { position = updatePosition world DOWN , updateScrn = True }
            SDLK_LEFT   -> world { position = updatePosition world LEFT , updateScrn = True }
            SDLK_RIGHT  -> world { position = updatePosition world RIGHT, updateScrn = True }
            SDLK_ESCAPE -> world { toquit   = True                                          }
            _           -> world
        Quit -> world { toquit = True }
        _    -> world

updatePosition :: World -> Move -> Point
updatePosition w move
    | move == DOWN  = if py > 1      then Point (px    , py - 1) else position w
    | move == LEFT  = if px > 1      then Point (px - 1, py    ) else position w
    | move == RIGHT = if px < boardx then Point (px + 1, py    ) else position w
    | otherwise     = position w
    where
        Point (px, py) = position w
