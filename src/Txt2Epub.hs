module Txt2Epub where
import Data.List
import qualified Data.Text as T

type Paragraph = T.Text

-- data Book = Book {
--      paragraphs :: [Paragraph]
-- }

-- amazingly, Data.Text lacks join
textJoin :: T.Text -> [T.Text] -> T.Text
textJoin _ [] = T.pack ""
textJoin _ [x] = x
textJoin delimiter (x:xs) = T.append x (T.append delimiter $ textJoin delimiter xs)

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

isParagraphStart :: T.Text -> Bool
isParagraphStart line = T.all (==(' ')) potentialIndent
                 where potentialIndent = T.take 4 line

join :: String -> [String] -> String
join delimiter (x:xs) = x ++ delimiter ++ join delimiter xs
join _ [] = []

-- Turn a list of of lists of lines, and join each list of lines into
-- a single Paragraph.
assembleParagraphs :: [[T.Text]] -> [Paragraph]
assembleParagraphs stringList = map (\s -> T.unwords s) stringList

-- Take input, a single string, and split it into individual
-- Paragraphs
readParagraphs :: String -> [Paragraph]
readParagraphs input = map (\p -> T.strip p) $ assembleParagraphs $ splitBy (isParagraphStart) $ map (\s -> T.pack s) $ lines input
