module Main where

import Graphics.UI.SDL     as SDL
import Control.Monad       (forever, forM_)

screenx = 800
screeny = 600

drawGrid surface = do
    forM_ [10, 20 .. 100] $ \x -> do
        forM_ [10, 20 .. 100] $ \y -> do
            --print (x, y)
            fillRect surface (Just (Rect x y (x+1) (y+1))) (Pixel 0xFFFFFF)

main = do
    SDL.init [InitEverything]

    setCaption "HATRIS" ""
    setVideoMode screenx screeny 24 [HWSurface, DoubleBuf]
    surface <- getVideoSurface

    forever $ do
        drawGrid surface

        SDL.flip surface

    SDL.quit
