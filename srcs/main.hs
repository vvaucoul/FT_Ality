-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   main.hs                                            :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: vvaucoul <vvaucoul@student.42.fr>          +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2023/10/18 14:40:18 by vvaucoul          #+#    #+#             --
--   Updated: 2023/10/18 17:09:20 by vvaucoul         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

import Modules.Datas (KeyAction, GameKeyAction, Combo)
import Modules.Parsing (parseGrammarFile)
import Modules.Game (gameLoop)
import Modules.Errors (putError)
import Modules.Colors (red, green, reset)

import System.Exit (exitSuccess)
import System.FilePath (takeExtension)
import System.Environment (getArgs)


printKeys :: [GameKeyAction] -> IO ()
printKeys keys = do
    putStrLn $ green ++ "Keys:" ++ reset
    mapM_ (\(k, a) -> putStrLn $ "\t" ++ [k] ++ " -> " ++ a) keys


printCombos :: [Combo] -> IO ()
printCombos combos = do
    putStrLn $ green ++ "Combos:" ++ reset
    mapM_ (\(c, m, k) -> putStrLn $ "\t" ++ m ++ "(" ++ c ++ "): " ++ k) combos


printLine :: IO ()
printLine = putStrLn $ green ++ "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" ++ reset


start :: String -> IO()
start grammarFile= do
    content <- readFile grammarFile
    putStrLn red
    case parseGrammarFile content of
        Right (keys, combos) -> do
            printLine
            printKeys keys
            printLine
            printCombos combos
            printLine
            gameLoop [] keys combos
        Left err -> putStrLn err


main :: IO ()
main = do
    args <- getArgs
    case args of
        [grammarFile] -> if takeExtension grammarFile == ".gmr" 
        then do
            start grammarFile
        else do
            putError "File extension must be .gmr"
            exitSuccess
        _ -> do
            putError "Error: Invalid number of arguments (expected 1)"
            exitSuccess
