module Graphics where

import Data

import Graphics.UI.SDL
import Graphics.UI.SDL.Primitives
import Control.Monad                (forM_)

drawGrid surface = do
    forM_ [0, dx .. dx*boardx] $ \x ->
        forM_ [0, dy .. dy*boardy] $ \y ->
           rectangle surface (Rect (x+posx) (y+posy) (posx+(x+dx)) (posy+(y+dy))) (Pixel 0xFFFFFF)
