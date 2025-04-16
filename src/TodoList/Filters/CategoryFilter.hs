module TodoList.Filters.CategoryFilter (categoryFilter) where

import TodoList.Core.Types

categoryFilter :: Category -> [Task] -> [Task]
categoryFilter targetCtg = filter (\task -> category task == targetCtg)
