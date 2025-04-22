module CLI.Interface (mainMenu) where

import CLI.TaskManagerMenu (taskManagerMenu)
import System.Exit (exitSuccess)
import System.IO (BufferMode (NoBuffering), hSetBuffering, stdin)
import Types

mainMenu :: [Task] -> IO [Task]
mainMenu tasks = do
  hSetBuffering stdin NoBuffering
  putStrLn "\ESC[33mInforme a opção desejada:"
  putStr "\ESC[0m"
  putStrLn "1 - Gerenciar suas Tarefas."
  putStrLn "2 - Gestão de Prazos."
  putStrLn "3 - Filtros Avançados."
  putStrLn "4 - Salvar/Carregar Arquivo."
  putStrLn "5 - Exibir Relatório."
  putStrLn "Q - Para sair sem salvar"
  opt <- getChar
  case opt of
    'q' -> exitSuccess
    'Q' -> exitSuccess
    '1' -> taskManagerMenu tasks
    '2' -> do
      putStrLn "Gestão de Prazos selecionada."
      return tasks
    '5' -> 
      -- showReport tasks = do
      --   putStrLn "Relatório Resumido:"
      --   let totalTasks = length tasks
      --   putStrLn $ " - Total de tarefas: " ++ show totalTasks
      --   let pendingTasks = length (filterByStatus Pending tasks)
      --   let completedTasks = length (filterByStatus Completed tasks)
      --   putStrLn $ " - Pendentes: " ++ show pendingTasks ++ " | Concluídas: " ++ show completedTasks
      --   if totalTasks > 0 then do
      --   putStrLn $ "Distribuição por Categoria:"
      --   let workTasks = length (categoryFilter Work tasks)
      --   let studyTasks = length (categoryFilter Study tasks)
      --   let personalTasks = length (categoryFilter Personal tasks)
      --   let otherTasks = length (categoryFilter Other tasks)
      --   putStrLn $ " * Trabalho: " ++ show workTasks ++ " (" ++ show (fromIntegral workTasks / fromIntegral totalTasks * 100) ++ "%)"
      --   putStrLn $ " * Estudo: " ++ show studyTasks ++ " (" ++ show (fromIntegral studyTasks / fromIntegral totalTasks * 100) ++ "%)"
      --   putStrLn $ " * Pessoal: " ++ show personalTasks ++ " (" ++ show (fromIntegral personalTasks / fromIntegral totalTasks * 100) ++ "%)"
      --   putStrLn $ " * Outros: " ++ show otherTasks ++ " (" ++ show (fromIntegral otherTasks / fromIntegral totalTasks * 100) ++ "%)"
      --   else putStrLn $ "Nenhuma tarefa cadastrada."
      --   return tasks
    _ -> do
      putStrLn "Operação inválida"
      return tasks
        
