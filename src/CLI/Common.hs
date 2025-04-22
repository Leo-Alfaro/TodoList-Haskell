module CLI.Common (getOption, invalidOption, parseError) where

import Text.Read (readMaybe)

getOption :: IO (Maybe Int)
getOption = getLine >>= return . readMaybe

invalidOption :: String
invalidOption = "Opção inválida"

parseError :: String
parseError = "Digite apenas números"
