module Main where
import Txt2Epub
import qualified Data.Text as T

main :: IO()
main = do
     text_contents <- getContents
     putStrLn $ T.unpack $ textJoin (T.pack "</p><p>") $ readParagraphs text_contents
