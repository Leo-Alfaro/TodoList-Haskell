module TodoList.Storage.TextFile (readTextFile, writeTextFile) where

readTextFile :: FilePath -> IO String
readTextFile = readFile

writeTextFile :: FilePath -> String -> IO ()
writeTextFile = writeFile
