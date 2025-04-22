module CLI.TaskManagerMenu (taskManagerMenu) where

import Data.List.Split (splitOn)
import Data.Time (Day)
import TaskManager (addTask, createTask, markCompleted, removeTask)
import Text.Read (readMaybe)
import Types

taskManagerMenu :: [Task] -> IO [Task]
taskManagerMenu tasks = do
  putStrLn "\ESC[33mGerenciador de Tarefas."
  putStr "\ESC[0m"
  putStrLn "1 - Adicionar Tarefa."
  putStrLn "2 - Remover Tarefa."
  putStrLn "3 - Marcar Tarefa como Concluída."
  opt <- getChar
  case opt of
    '1' -> action addTask (createTaskInput tasks) tasks >>= taskManagerMenu
    '2' -> action removeTask (removeTaskInput tasks) tasks >>= taskManagerMenu
    '3' -> action markCompleted (markCompletedInput tasks) tasks >>= taskManagerMenu
    _ -> putStrLn "Operação inválida" >> return tasks
  where
    action f inputIO currentTasks = do
      inputEither <- inputIO
      case inputEither of
        Left err -> do
          putStrLn $ "Erro: " ++ err
          return currentTasks
        Right value -> return (f value currentTasks)

createTaskInput :: [Task] -> IO (Either String Task)
createTaskInput tasks = do
  eId <- _getId tasks
  eDesc <- _getDescription
  eStatus <- _getStatus
  ePriority <- _getPriority
  eCategory <- _getCategory
  eDeadline <- _getDeadline
  eTags <- _getTags

  return $ do
    id <- eId
    desc <- eDesc
    status <- eStatus
    priority <- ePriority
    category <- eCategory
    deadline <- eDeadline
    tags <- eTags
    Right $ createTask id desc status priority category deadline tags

removeTaskInput :: [Task] -> IO (Either String Int)
removeTaskInput tasks = do
  print tasks
  putStr "Insira o ID para remover: "
  input <- readMaybe <$> getLine
  return $ case input of
    Just searchId ->
      if any (\t -> taskId t == searchId) tasks
        then Right searchId
        else Left "ID não encontrado!"
    Nothing -> Left "ID inválido!"

markCompletedInput :: [Task] -> IO (Either String Int)
markCompletedInput tasks = do
  print tasks
  putStr "Insira o ID para marcar como concluída: "
  input <- readMaybe <$> getLine
  return $ case input of
    Just searchId ->
      if any (\t -> taskId t == searchId) tasks
        then Right searchId
        else Left "ID não encontrado!"
    Nothing -> Left "ID inválido!"

checkId :: [Task] -> Maybe Int -> Either String Int
checkId _ Nothing = Left "ID inválido!"
checkId tasks (Just searchId) =
  if any (\task -> taskId task == searchId) tasks
    then Left "ID já existe!"
    else Right searchId

_getId :: [Task] -> IO (Either String Int)
_getId tasks = do
  putStr "Digite o ID da Task: "
  input <- readMaybe <$> getLine
  return $ checkId tasks input

_getDescription :: IO (Either String String)
_getDescription = do
  putStr "Descrição da tarefa: "
  desc <- getLine
  return $ if null desc then Left "Descrição vazia!" else Right desc

_getStatus :: IO (Either String Status)
_getStatus = do
  putStrLn "Status da tarefa:"
  putStrLn "1 - Pendente | 2 - Concluída"
  putStr "Escolha: "
  input <- readMaybe <$> getLine
  return $ case input of
    Just 1 -> Right Pending
    Just 2 -> Right Completed
    _ -> Left "Status inválido!"

_getPriority :: IO (Either String Priority)
_getPriority = do
  putStrLn "Prioridade da tarefa:"
  putStrLn "1 - Baixa | 2 - Média | 3 - Alta"
  putStr "Escolha: "
  input <- readMaybe <$> getLine
  return $ case input of
    Just 1 -> Right Low
    Just 2 -> Right Medium
    Just 3 -> Right High
    _ -> Left "Prioridade inválida!"

_getCategory :: IO (Either String Category)
_getCategory = do
  putStrLn "Categoria da tarefa:"
  putStrLn "1 - Trabalho | 2 - Estudo | 3 - Pessoal | 4 - Outro"
  putStr "Escolha: "
  input <- readMaybe <$> getLine
  return $ case input of
    Just 1 -> Right Work
    Just 2 -> Right Study
    Just 3 -> Right Personal
    Just 4 -> Right Other
    _ -> Left "Categoria inválida!"

_getDeadline :: IO (Either String (Maybe Day))
_getDeadline = do
  putStr "Prazo (AAAA-MM-DD ou vazio): "
  input <- getLine
  return $
    if null input
      then Right Nothing
      else maybe (Left "Formato de data inválido!") (Right . Just) (readMaybe input)

_getTags :: IO (Either String [String])
_getTags = do
  putStr "Tags (separadas por vírgula): "
  input <- getLine
  return $ Right $ splitOn "," input
