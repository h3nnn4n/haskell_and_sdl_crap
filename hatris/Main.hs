module Main where

import Graphics.UI.SDL     as SDL
import Control.Monad       (forever, forM_)
import Graphics.UI.SDL.Primitives

screenx = 800
screeny = 600

boardx = 10
boardy = 25

dy = div screeny boardy
dx = dy

posx = (div screenx 2) - (div boardx 2)*dx
posy = (div screeny 2) - (div boardy 2)*dy

drawGrid surface = do
    forM_ [10, 10+dx .. dx*boardx] $ \x -> do
        forM_ [10, 10+dy .. dy*boardy] $ \y -> do
           rectangle surface (Rect (x+posx) (y+posy) (posx+(x+dx)) (posy+(y+dy))) (Pixel 0xFFFFFF)

main = do
    SDL.init [InitEverything]

    setCaption "HATRIS" ""
    setVideoMode screenx screeny 24 [HWSurface, DoubleBuf]
    surface <- getVideoSurface

    forever $ do
        drawGrid surface

        SDL.flip surface

    SDL.quit

