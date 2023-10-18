-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   Game.hs                                            :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: vvaucoul <vvaucoul@student.42.fr>          +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2023/10/18 14:40:20 by vvaucoul          #+#    #+#             --
--   Updated: 2023/10/18 17:08:39 by vvaucoul         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

module Modules.Game where

import Modules.Datas (KeyAction, GameKeyAction, Combo)
import Modules.Colors ( red, green, yellow, blue, magenta, cyan, reset )

import Data.List ( intercalate, isInfixOf )
import Data.Maybe ( fromMaybe )
import System.Random (randomRIO)
import System.IO ( hSetBuffering, stdin, BufferMode(NoBuffering), hSetEcho )


generateSentence :: String -> String -> IO String
generateSentence character move = do
    let sentences = [ " used ", " annihilated with ", " destroyed using ", 
                      " performed ", " unleashed ", " executed ", " obliterated with ", 
                      " decimated using ", " finished with ", " crushed with ", 
                      " FATALITY ", " BRUTALITY ", " FLAWLESS ", " OUTSTANDING ", 
                      " dominated using " ]
    idx <- randomRIO (0, length sentences - 1)
    let sentence = sentences !! idx
    let ending = if idx `elem` [0, 1, 10, 11, 12] then "!" else "."
    return $ red ++ character ++ reset ++ sentence ++ cyan ++ move ++ reset ++ ending ++ "\n"


printInputStack :: String -> [GameKeyAction] -> IO ()
printInputStack inputStack keyActions = do
    let translatedInputStack = filter (/= "") $ map (\i -> fromMaybe "" (lookup i keyActions)) (reverse inputStack)
    case translatedInputStack of
        [] -> return ()
        (x:xs) -> do
            putStr x
            mapM_ (\i -> putStr $ ", " ++ i) xs
            putStrLn ""


gameLoop :: String -> [GameKeyAction] -> [Combo] -> IO ()
gameLoop inputStack keyActions combos = do
    hSetBuffering stdin NoBuffering
    hSetEcho stdin False

    -- Get input
    input <- getChar

    let action = lookup input keyActions
    case action of
        Just _  -> do
            -- Update the input stack only if key is recognized
            let newInputStack = input : inputStack

            -- Print the updated input stack
            printInputStack newInputStack keyActions
            putStrLn ""
            
            -- Rest of the logic
            let translatedInput = intercalate "," $ map (\i -> fromMaybe "" (lookup i keyActions)) (reverse newInputStack)
            let matchingCombos = filter (\(_, _, combo) -> combo `isInfixOf` translatedInput) combos
            if null matchingCombos
            then gameLoop newInputStack keyActions combos
            else do
                mapM_ (\(character, move, _) -> do
                            sentence <- generateSentence character move
                            putStrLn sentence
                      ) matchingCombos
                gameLoop [] keyActions combos  -- Reset the input stack
        Nothing -> gameLoop inputStack keyActions combos  -- Do not update the input stack
