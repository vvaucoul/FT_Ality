# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vvaucoul <vvaucoul@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/10/03 18:51:44 by vvaucoul          #+#    #+#              #
#    Updated: 2023/10/18 17:10:36 by vvaucoul         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ! ||--------------------------------------------------------------------------------||
# ! ||                     Check if GHC Is installed and available                    ||
# ! ||--------------------------------------------------------------------------------||

CHECK_GHC = $(shell command -v $(GHC) 2> /dev/null)

ifeq ($(CHECK_GHC), 0)
$(warning GHC not found, building...)
build:
	./scripts/build.sh
endif

ifeq ($(CHECK_GHC), 0)
	HC = ./scripts/ghc/ghc
else
	HC = ghc
endif

NAME = ft_ality
FLAGS = -i./Modules
SRC_DIR = srcs
OUT_DIR = bin
MODULES_DIR = Modules

SRCS_DIR = srcs
SRCS =	$(shell find $(SRCS_DIR) -type f -name "*.hs") \
		$(shell find $(MODULES_DIR) -type f -name "*.hs")

.PHONY: build

all: dirs $(OUT_DIR)/$(NAME)

dirs:
	@mkdir -p $(OUT_DIR)

$(OUT_DIR)/$(NAME): $(SRCS)
	$(HC) $(FLAGS) -o $@ $<
	@echo "Building..."

clean:
	@echo "Cleaning object files..."
	@rm -f $(SRC_DIR)/*.hi $(SRC_DIR)/*.o
	@rm -f $(MODULES_DIR)/*.hi $(MODULES_DIR)/*.o

fclean: clean
	@echo "Cleaning executable..."
	@rm -f $(OUT_DIR)/$(NAME)
	@rm -rf $(OUT_DIR)

re: fclean all

run: all
	$(OUT_DIR)/$(NAME) $(PARAM)

run-gmr: all
	$(OUT_DIR)/$(NAME) "grammar/grammar.gmr"

check: all
	$(OUT_DIR)/$(NAME) "grammar/testFiles/bad_combo.gmr"
	$(OUT_DIR)/$(NAME) "grammar/testFiles/bad_key.gmr"
	$(OUT_DIR)/$(NAME) "grammar/testFiles/duplicate_action_in_keys.gmr"
	$(OUT_DIR)/$(NAME) "grammar/testFiles/duplicate_key_in_keys.gmr"
	$(OUT_DIR)/$(NAME) "grammar/testFiles/duplicate_key.gmr"
	$(OUT_DIR)/$(NAME) "grammar/testFiles/empty_line.gmr"
	$(OUT_DIR)/$(NAME) "grammar/testFiles/no_separator.gmr"
	$(OUT_DIR)/$(NAME) "grammar/testFiles/unknown_action_in_combo.gmr"
	
.PHONY: all clean fclean re run dirs run-gmr check