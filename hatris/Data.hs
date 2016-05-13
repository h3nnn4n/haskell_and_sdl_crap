module Data where

data Piece = Blocks [Block]

data Block = Point (Int, Int)

data World = Pieces [Piece]

screenx, screeny :: Int
screenx = 800
screeny = 600

boardx, boardy :: Int
boardx = 10
boardy = 25

dx, dy :: Int
dy = div screeny (boardy+1)
dx = dy

posx, posy :: Int
posx = (div screenx 2) - (div boardx 2)*dx
posy = (div screeny 2) - (div boardy 2)*dy
