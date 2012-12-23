-- Adapted from an example by Don Stewart. For licensing information
-- please see the file "example/Test/Framework/Example.lhs" in the source tree.
import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.HUnit
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Test.QuickCheck
import Test.HUnit

import Data.List

import Txt2Epub

main = defaultMain tests

tests = [testGroup "TXT2EPUB" [
                -- testProperty "splitBy" prop_splitBy,
                testCase "splitBySimple" test_splitBy
        ]]

-- need to arrange for the generated arrays never to have the boundary value...?
-- prop_splitBy left right = splitBy (==(last left)) (concat [left, right]) == [left, right]
--              where types = ( left :: [Int], right :: [Int] )

test_splitBy = splitBy (==20) [0, 1, 2, 20, 3, 4] @?= [[0, 1, 2], [3, 4]]
