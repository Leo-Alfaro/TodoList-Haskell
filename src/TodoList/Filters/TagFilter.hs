module TodoList.Filters.TagFilter (tagFilter) where

import TodoList.Core.Types

tagFilter :: String -> [Task] -> [Task]
tagFilter targetTag = filter (\task -> targetTag `elem` tags task)
