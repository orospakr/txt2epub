type Paragraph = String

-- data Book = Book {
--      paragraphs :: [Paragraph]
-- }

splitBy :: (a -> Bool) -> [a] -> [[a]]
-- splitBy :: (String -> Bool) -> [String] -> [[String]]
splitBy predicate list = left : splitBy predicate right
        where (left, right) = span predicate list

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

-- approaches:
-- * use span with a predicate for matching indents
-- * recurse 

main :: IO()
main = do
     text_contents <- getContents
     putStrLn $ join "PARAGRAPH: \n" $ readParagraphs text_contents
