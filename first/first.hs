import Prelude
import Graphics.UI.SDL as SDL

hello      = "hello_world.bmp"

xres = 640
yres = 480

main = do
  SDL.init [InitEverything]
  setVideoMode xres yres 32 []
  image  <- loadBMP hello
  screen <- getVideoSurface
  blitSurface image Nothing screen (Just (Rect 180 140 0 0))
  SDL.flip screen

  loop screen image 0 0 5 5

loop screen image x y dx dy = do
    blitSurface image Nothing screen (Just (Rect x y 0 0))

    SDL.flip screen

    let (xx, yy, ddx, ddy) = getNewPos x y dx dy

    loop screen image xx yy ddx ddy

getNewPos x y dx dy = (newX, newY, ddx, ddy)
    where
        dy' = dy + 2
        (newY, ddy) = if y + dy' > yres - 105 || y + dy' < 0
                        then (y, dy' * (-1))
                        else (y + dy', dy')
        (newX, ddx) = if x + dx > xres - 91 || x + dx < 0
                        then (x, dx * (-1))
                        else (x + dx, dx)

