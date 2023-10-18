-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   Colors.hs                                          :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: vvaucoul <vvaucoul@student.42.fr>          +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2023/10/18 15:20:12 by vvaucoul          #+#    #+#             --
--   Updated: 2023/10/18 17:08:20 by vvaucoul         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

module Modules.Colors where

-- Colors
red :: String
red = "\ESC[1;31m"

green :: String
green = "\ESC[1;32m"

yellow :: String
yellow = "\ESC[1;33m"

blue :: String
blue = "\ESC[1;34m"

magenta :: String
magenta = "\ESC[1;35m"

cyan :: String
cyan = "\ESC[1;36m"

reset :: String
reset = "\ESC[0m"
