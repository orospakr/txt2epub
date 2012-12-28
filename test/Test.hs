-- Adapted from an example by Don Stewart. For licensing information
-- please see the file "example/Test/Framework/Example.lhs" in the source tree.
import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.HUnit
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Test.QuickCheck
import Test.HUnit

import Data.List
import qualified Data.Text as T

import Txt2Epub

main = defaultMain tests

tests = [testGroup "TXT2EPUB" [
                -- testProperty "splitBy" prop_splitBy,
                testCase "Split By should split by predicate" test_splitBy,
                testCase "Split By should handle beginning bound" test_splitByBeginning,
                testCase "Split By should handle multiple hits" test_splitByAtLeastThree,
                testCase "Split By should handle empty split at the end" test_splitByEnd,

                testCase "SplitAts should handle beginning bound" test_splitAtsBeginning,

                testCase "SplitAts should handle empty split at the end" test_splitAtsEnd,

                testCase "SplitAts should handle multiple splits" test_splitAtsMultiple,

                testCase "Join should handle empty list" test_joinEmpty,

                testCase "Join should handle single item" test_joinSingle,

                testCase "Join should multiple items" test_joinMultiple
        ]]

-- need to arrange for the generated arrays never to have the boundary value, or for the predicate to be generic somehow...?
-- prop_splitBy left right = splitBy (==(last left)) (concat [left, right]) == [left, right]
--              where types = ( left :: [Int], right :: [Int] )

test_splitBy = splitBy (==20) [0, 1, 2, 20, 3, 4] @?= [[0, 1, 2], [20, 3, 4]]

test_splitByBeginning = splitBy (==20) [20, 0, 1, 2, 20, 3, 4] @?= [[20, 0, 1, 2], [20, 3, 4]]

test_splitByAtLeastThree = splitBy (==20) [0, 1, 2, 20, 3, 4, 20, 31, 32, 33, 20, 41, 42] @?= [[0, 1, 2], [20, 3, 4], [20, 31, 32, 33], [20, 41, 42]]

test_splitByEnd = splitBy (==20) [0, 1, 2, 20, 3, 4, 20] @?= [[0, 1, 2], [20, 3, 4], [20]]

test_splitAtsBeginning = splitAts [0] [1, 2, 3, 4] @?= [[1, 2, 3, 4]]

test_splitAtsEnd = splitAts [4] [1, 2, 3, 4] @?= [[1, 2, 3, 4]]

test_splitAtsMultiple = splitAts [3, 4, 8] [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] @?= [[5, 6, 7], [8], [9, 10, 11, 12], [13, 14, 15, 16]]

test_joinEmpty = textJoin (T.pack "LOL") [] @?= T.pack ""

test_joinSingle = textJoin (T.pack "LOL") [T.pack "oi"] @?= T.pack "oi"

test_joinMultiple = textJoin (T.pack "foo") [T.pack "bar", T.pack "baz"] @?= T.pack "barfoobaz"
