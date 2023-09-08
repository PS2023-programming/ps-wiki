build:
	@mkdocs build
	@cd site;\
	git add .;\
	git commit --allow-empty -m "auto-build";\
	git push origin master

clean:
	-@rm -rf site

.PHONY: build