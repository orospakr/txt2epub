module Main where
import Txt2Epub

main :: IO()
main = do
     text_contents <- getContents
     putStrLn $ join "\n PARAGRAPH: " $ readParagraphs text_contents
