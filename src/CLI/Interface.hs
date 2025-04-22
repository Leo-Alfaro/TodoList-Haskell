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
    _ -> do
      putStrLn "Operação inválida"
      return tasks
