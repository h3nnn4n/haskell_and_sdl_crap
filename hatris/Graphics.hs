module Graphics where

import Data

import Graphics.UI.SDL
import Graphics.UI.SDL.Primitives
import Control.Monad                (forM_)

drawGrid surface = do
    forM_ [0, dx .. dx*boardx] $ \x ->
        forM_ [0, dy .. dy*boardy] $ \y ->
           rectangle surface (Rect (x+posx) (y+posy) (posx+(x+dx)) (posy+(y+dy))) (Pixel 0x222422)

drawPos surface (Point (px, py)) = do
    rectangle surface (Rect (posx+px') (posy-py') (posx+dx+px') (posy-(dy+py'))) (Pixel 0xA8B6A4)
    --print (py', py'-posy, posy-(py'+dy))
    return ()
    where
        px' = px * dx
        py' = (py-boardy-1) * dy
