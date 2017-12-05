module Poly.Translations
  ( scale
  ) where

import qualified Data.Vector as V

import Coords (Point(..))
import Poly (Poly(..))
import Poly.Properties (centroid)

scale :: Double -> Poly -> Poly
scale factor Poly {vertices} = Poly {vertices = vertices'}
  where
    vertices' = V.zipWith (+) vertices deltas
    deltas = V.map (\point -> Point {x = factor', y = factor'} * (point - c)) vertices
    factor' =
      if factor >= 1
        then factor - 1
        else -1 * (1 - factor)
    c = centroid Poly {vertices}
