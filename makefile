.PHONY: validate-submodule
validate-submodule:
ifndef submodule
	$(error submodule is undefined (eg submodule=https://github.com/tpope/vim-repeat.git))
endif

.PHONY: validate-path
validate-path:
ifndef path
	$(error path is undefined (eg path=pack/downloads/start/repeat))
endif


# make init
.PHONY: init
init:
	git submodule update --init
	npm install --no-package-lock --prefix pack/downloads/opt/markdown-preview pack/downloads/opt/markdown-preview

# make update
.PHONY: update
update:
	git submodule update --remote --merge
	npm install --no-package-lock --prefix pack/downloads/opt/markdown-preview pack/downloads/opt/markdown-preview

# make pull
.PHONY: pull
pull:
	git pull
	npm install --no-package-lock --prefix pack/downloads/opt/markdown-preview pack/downloads/opt/markdown-preview

# make add submodule=https://github.com/tpope/vim-repeat.git path=pack/downloads/start/repeat
.PHONY: add
add: validate-submodule validate-path
	git submodule add $(submodule) $(path)

# make rm path=pack/downloads/start/repeat
.PHONY: rm
rm: validate-path
	git rm $(path) -f
	rm -rf .git/modules/$(path)

# make diff dir1=vim dir2=vim.backup
.PHONY: diff
diff:
	diff -r --exclude .git --exclude pack/downloads --exclude tmux/plugins $(dir1) $(dir2)
