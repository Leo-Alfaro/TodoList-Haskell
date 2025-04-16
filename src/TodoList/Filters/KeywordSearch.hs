module TodoList.Filters.KeywordSearch (keywordSearch) where

import Data.Char (toLower)
import Data.List (isInfixOf)
import TodoList.Core.Types

toLowerStr :: String -> String
toLowerStr = map toLower

keywordSearch :: String -> [Task] -> [Task]
keywordSearch keyword = filter (\task -> toLowerStr keyword `isInfixOf` toLowerStr (description task))
