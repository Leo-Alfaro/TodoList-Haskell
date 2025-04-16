module Main (main) where

import Data.Time.Calendar (fromGregorian)
import TodoList.Core.Types
import TodoList.Filters.CategoryFilter (categoryFilter)
import TodoList.Filters.StatusFilter (filterByStatus)

main :: IO ()
main = do
  let tasks =
        [ Task
            { taskId = 1,
              description = "Estudar Haskell",
              status = Pending,
              priority = High,
              category = Study,
              deadline = Just (fromGregorian 2025 4 15),
              tags = ["urgente", "faculdade"]
            },
          Task
            { taskId = 2,
              description = "Reunião com cliente",
              status = Completed,
              priority = Medium,
              category = Work,
              deadline = Just (fromGregorian 2024 12 10),
              tags = ["projeto", "apresentação"]
            },
          Task
            { taskId = 3,
              description = "Fazer exercícios",
              status = Pending,
              priority = Low,
              category = Personal,
              deadline = Nothing,
              tags = ["saúde", "ginástica"]
            }
        ]

  mapM_ (putStrLn . show) tasks
  mapM_ (putStrLn . show) (filterByStatus Pending tasks)
  mapM_ (putStrLn . show) (categoryFilter Personal tasks)
