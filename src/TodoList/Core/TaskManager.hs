module TodoList.Core.TaskManager (addTask, markCompleted) where

import TodoList.Core.Types

addTask :: Task -> [Task] -> [Task]
addTask task xt = task : xt

markCompleted :: Int -> [Task] -> [Task]
markCompleted targetId tasks = map updateStatus tasks
  where
    updateStatus task
      | taskId task == targetId = task {status = Completed}
      | otherwise = task
