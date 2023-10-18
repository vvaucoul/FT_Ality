-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   Errors.hs                                          :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: vvaucoul <vvaucoul@student.42.fr>          +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2023/10/18 15:34:44 by mle-faou          #+#    #+#             --
--   Updated: 2023/10/18 17:08:27 by vvaucoul         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

module Modules.Errors where

import Modules.Colors (red, reset)

putError :: String -> IO ()
putError msg = putStrLn $ red ++ "Error: " ++ msg ++ reset

leftError :: String -> Either String a
leftError msg = Left $ red ++ "Error: " ++ msg ++ reset
