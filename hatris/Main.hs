module Main where

import Data

import Graphics.UI.SDL     as SDL
import Control.Monad       (forever, forM_)
import Graphics.UI.SDL.Primitives

drawGrid surface = do
    forM_ [0, dx .. dx*boardx] $ \x -> do
        forM_ [0, dy .. dy*boardy] $ \y -> do
           rectangle surface (Rect (x+posx) (y+posy) (posx+(x+dx)) (posy+(y+dy))) (Pixel 0xFFFFFF)

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
            SDL.flip surface
            gameLoop surface world


eventHandler :: Event -> World -> World
eventHandler event world =
    case event of
        Quit -> world { toquit = True }
        KeyDown (Keysym key _ _) -> case key of
            SDLK_DOWN  -> world { position = updatePosition world DOWN  }
            SDLK_LEFT  -> world { position = updatePosition world LEFT  }
            SDLK_RIGHT -> world { position = updatePosition world RIGHT }
            _      -> world
        _    -> world

updatePosition :: World -> Move -> Point
updatePosition w move
    | move == DOWN  = if py > 1      then Point (px    , py - 1) else position w
    | move == LEFT  = if px > 1      then Point (px - 1, py    ) else position w
    | move == RIGHT = if px < boardx then Point (px + 1, py    ) else position w
    | otherwise     = position w
    where
        Point (px, py) = position w
