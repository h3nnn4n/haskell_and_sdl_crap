module Data where

-- World is a list of blocks(Points), an integer with the points,
-- the current piece, its coordinates and the next piece.
--data World = Pieces ([Point], Int, Piece, Point, Piece)
data World = World
    { blocks    :: [Point]
    , score     :: Int
    , falling   :: Piece
    , position  :: Point
    , nextPiece :: Piece
    , toquit    :: Bool
    }

-- A piece is made of blocks, which are 2d points
data Piece = Piece [Point]
data Point = Point (Int, Int)

-- A data type to pass around which direction pieces should go
data Move = LEFT | RIGHT | DOWN
    deriving Eq

-- The screen resolution
screenx, screeny :: Int
screenx = 800
screeny = 600

-- Board size
boardx, boardy :: Int
boardx = 10
boardy = 25

-- The size of each cell
dx, dy :: Int
dy = div screeny (boardy+1)
dx = dy

-- Where the cell starts
-- It calculates where to draw the grid so it can be centered on the screen
posx, posy :: Int
posx = (div screenx 2) - (div boardx 2)*dx
posy = (div screeny 2) - (div boardy 2)*dy

newWorld = World
    { blocks    = []
    , score     = 0
    , falling   = Piece [Point (1,1)]
    , position  = Point (1, 1)
    , nextPiece = Piece [Point (1,1), Point (1,2)]
    , toquit    = False
    }
