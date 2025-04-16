module TodoList.Filters.PrioritySorter (prioritySorter) where

import Data.List (sortBy)
import Data.Ord (comparing)
import TodoList.Core.Types

prioritySorter :: [Task] -> [Task]
prioritySorter = sortBy (comparing priority)
