module Txt2Epub where
import Data.List

type Paragraph = String

-- data Book = Book {
--      paragraphs :: [Paragraph]
-- }

splitByDropDelim :: (a -> Bool) -> [a] -> [[a]]
-- splitBy :: (String -> Bool) -> [String] -> [[String]]
splitByDropDelim _ [] = []
splitByDropDelim predicate list = if (null left) then (splitByDropDelim predicate $ tail remaining) else ([left] ++ splitByDropDelim predicate remaining)
        where (left, remaining) = break predicate list

splitAts' :: [Int] -> [a] -> Int -> [[a]]
splitAts' _ [] _ = []
splitAts' [] list _ = [list]
splitAts' indices list previousIndex = if (null left) then next else [left] ++ next 
         where myIndex = head indices
               left = take (myIndex - previousIndex) list
               right = drop (myIndex - previousIndex) list
               next = splitAts' (tail indices) right myIndex

splitAts :: [Int] -> [a] -> [[a]]
splitAts indices list = splitAts' indices list 0

splitBy predicate list = splitAts indices list
       where indices = findIndices predicate list

isParagraphStart :: String -> Bool
isParagraphStart line = all (==' ') potentialIndent
                 where potentialIndent = take 4 line

join :: String -> [String] -> String
join delimiter (x:xs) = x ++ delimiter ++ join delimiter xs
join _ [] = []

mergeInner :: [[String]] -> [Paragraph]
mergeInner stringList = map (\s -> join " " s) stringList

-- Take input, a single string, and split it into individual Paragraphs
readParagraphs :: String -> [Paragraph]
readParagraphs input = mergeInner $ splitBy (isParagraphStart) $ lines input
