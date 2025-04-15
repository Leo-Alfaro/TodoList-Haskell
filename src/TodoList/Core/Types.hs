module TodoList.Core.Types where

import Data.Time.Calendar (Day)

data Status = Pending | Completed deriving (Show, Eq)

data Priority = Low | Medium | High deriving (Show, Eq, Ord)

data Category = Work | Study | Personal | Other deriving (Show, Eq)

data Task = Task
  { taskId :: Int,
    description :: String,
    status :: Status,
    priority :: Priority,
    category :: Category,
    deadline :: Maybe Day,
    tags :: [String]
  }
  deriving (Show, Eq)
