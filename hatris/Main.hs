module Main where

import Data

import Graphics.UI.SDL     as SDL
import Control.Monad       (forever, forM_)
import Graphics.UI.SDL.Primitives

drawGrid surface = do
    forM_ [0, dx .. dx*boardx] $ \x -> do
        forM_ [0, dy .. dy*boardy] $ \y -> do
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

