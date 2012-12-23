module Main where
import Txt2Epub

main :: IO()
main = do
     text_contents <- getContents
     putStrLn $ join "PARAGRAPH: \n" $ readParagraphs text_contents
