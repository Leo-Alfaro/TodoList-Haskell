module Main (main) where

import Data.Time.Calendar (fromGregorian)
import TodoList.Core.Types

main :: IO ()
main = do
  let dummyTask =
        Task
          { taskId = 1,
            description = "Estudar Haskell",
            status = Pending,
            priority = High,
            category = Study,
            deadline = Just (fromGregorian 2025 4 15),
            tags = ["urgente", "faculdade"]
          }

  putStrLn $ "Task Description: " ++ description dummyTask
  putStrLn $ "Status: " ++ show (status dummyTask)
  putStrLn $ "Priority: " ++ show (priority dummyTask)
