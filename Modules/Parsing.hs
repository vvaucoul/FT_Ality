-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   Parsing.hs                                         :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: vvaucoul <vvaucoul@student.42.fr>          +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2023/10/18 14:55:52 by mle-faou          #+#    #+#             --
--   Updated: 2023/10/18 17:06:41 by vvaucoul         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

module Modules.Parsing where
    
import Modules.Datas (KeyAction, GameKeyAction, Combo)
import Modules.Errors (putError, leftError)
import Modules.Colors (red, reset)

import Data.List.Split (splitOn)
import Data.List (nub)


parseGrammarFile :: String -> Either String ([GameKeyAction], [Combo])
parseGrammarFile content = do
    let separatedLines = break (=="---") (lines content)
    case separatedLines of
        (keyPart, _:comboPart) -> do
            keys <- mapM parseKeyAction keyPart
            let gameKeys = [(head k, a) | (k, a) <- keys, length k == 1]
            combos <- mapM parseCombo comboPart
            validateKeysAndCombos gameKeys combos
        _ -> leftError "Missing '---' delimiter in grammar file"


validateKeysAndCombos :: [GameKeyAction] -> [Combo] -> Either String ([GameKeyAction], [Combo])
validateKeysAndCombos gameKeys combos = do
    let keys' = [k | (k, _) <- gameKeys]
    let testKeysActions = nub [a | (_, a) <- gameKeys]
    let testCombosActions = nub (concat [splitOn "," k | (_, _, k) <- combos])
    if length keys' /= length (nub keys') then
        leftError "Duplicate key bind"
    else if length gameKeys /= length (nub [a | (_, a) <- gameKeys]) then
        leftError "Duplicate key action"
    else if not (all (`elem` testKeysActions) testCombosActions) then
        leftError "Unknown action used in combos"
    else
        return (gameKeys, combos)


parseKeyAction :: String -> Either String KeyAction
parseKeyAction line =
    if null line then
        leftError "Error: Empty line found"
    else case splitOn "-" line of
        [key, action] -> Right (key, action)
        _ -> leftError $ "Error: Missing '-' in keys part: \"" ++ line ++ "\""


parseCombo :: String -> Either String Combo
parseCombo line =
    if null line then
        leftError "Error: Empty line found"
    else case splitOn "/" line of
        [character, move, keys] -> Right (character, move, keys)
        _ -> leftError $ "Error: Missing '/' in combos part: \"" ++ line ++ "\""
