module TodoList.Filters.PriorityFilter (priorityFilter) where

import TodoList.Core.Types

priorityFilter :: Priority -> [Task] -> [Task]
priorityFilter targetPrt = filter (\task -> priority task == targetPrt)

