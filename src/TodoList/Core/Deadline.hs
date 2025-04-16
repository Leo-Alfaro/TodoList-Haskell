module TodoList.Core.Deadline (checkOverdueTasks) where

import Data.Time (Day, diffDays)
import TodoList.Core.Types

checkOverdueTasks :: [Task] -> Day -> [Task]
checkOverdueTasks [] _ = []
checkOverdueTasks (x : xs) day
  | Nothing <- (deadline x) = checkOverdueTasks xs day
  | Just validDay <- (deadline x), validDay < day = x : checkOverdueTasks xs day
  | otherwise = checkOverdueTasks xs day
