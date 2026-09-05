HUGO_VERSION ?= 0.162.1
HUGO ?= ./.tools/hugo-$(HUGO_VERSION)/hugo
HOST ?= 127.0.0.1
PORT ?= 1313
BASE_URL ?= http://$(HOST):$(PORT)/
MSG ?= Update site $(shell date)
PUBLIC_BRANCH ?= master

.PHONY: serve ensure-hugo build deploy

ensure-hugo:
	@if [ ! -x "$(HUGO)" ]; then \
		echo "Installing Hugo $(HUGO_VERSION)..."; \
		mkdir -p "$$(dirname "$(HUGO)")"; \
		curl -L --fail -o "$$(dirname "$(HUGO)")/hugo.tar.gz" "https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_linux-amd64.tar.gz"; \
		tar -xzf "$$(dirname "$(HUGO)")/hugo.tar.gz" -C "$$(dirname "$(HUGO)")"; \
	fi

serve: ensure-hugo
	$(HUGO) server --buildDrafts --buildFuture --disableFastRender --bind $(HOST) --port $(PORT) --baseURL $(BASE_URL)

build: ensure-hugo
	$(HUGO)

deploy: build
	@printf '\033[0;32mDeploying updates to GitHub...\033[0m\n'
	@set -e; \
	git -C public add .; \
	if git -C public diff --cached --quiet; then \
		echo "No generated public changes to commit."; \
	else \
		git -C public commit -m "$(MSG)"; \
		public_commit=$$(git -C public rev-parse HEAD); \
		git -C public checkout $(PUBLIC_BRANCH); \
		git -C public merge "$$public_commit"; \
	fi
	git -C public push
	git add public
	@if git diff --cached --quiet -- public; then \
		echo "No public submodule update to commit."; \
	else \
		git commit -s -m "Update public submodule" -- public; \
	fi
	git push
