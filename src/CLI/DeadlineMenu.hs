module CLI.DeadlineMenu (deadlineMenu) where

import CLI.Common
import Control.Monad (liftM2)
import Data.Time.Clock
import Deadline
import Types

overdueTasks :: [Task] -> IO [Task]
overdueTasks tasks = getCurrentTime >>= (\time -> return (checkOverdueTasks tasks (utctDay time)))

tasksRemainingDays :: [Task] -> IO [(String, Maybe Int)]
tasksRemainingDays tasks = getCurrentTime >>= (\time -> return [(description t, remainingDays t (utctDay time)) | t <- tasks])

deadlineHelp :: String
deadlineHelp = "1 - Tarefas expiradas\n2 - Tempo restante\n0 - voltar"

deadlineMenu :: [Task] -> IO [Task]
deadlineMenu tasks = do
  putStrLn deadlineHelp
  option <- getOption
  _manageOptions option tasks
  where
    _manageOptions Nothing = (>>) (putStrLn parseError) . return
    _manageOptions (Just 0) = return
    _manageOptions (Just 1) = liftM2 (>>) (((=<<) (mapM_ print)) . overdueTasks) return
    _manageOptions (Just 2) = liftM2 (>>) (((=<<) (mapM_ print)) . tasksRemainingDays) return
    _manageOptions (Just _) = (>>) (putStrLn invalidOption) . return
