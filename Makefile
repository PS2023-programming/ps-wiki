build:
	@mkdocs build
	@if ! [ -d site/.git ]; then \
		cd site; git init; git remote add origin git@github.com:PS2023-programming/PS2023-programming.github.io.git; \
	fi
	@cd site;\
	git add .;\
	git commit --allow-empty -m "auto-build";\
	git push --force origin master
	
clean:
	-@rm -rf site

.PHONY: build clean init