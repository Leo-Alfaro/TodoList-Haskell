module TodoList.Filters.StatusFilter (filterByStatus) where

import TodoList.Core.Types

filterByStatus :: Status -> [Task] -> [Task]
filterByStatus st = filter (\task -> status task == st)
