IMAGE_REPO=ghcr.io/dgrebb/manual-approval

.PHONY: build
build:
	@if [ -z "$$VERSION" ]; then \
		echo "VERSION is required"; \
		exit 1; \
	fi
	docker buildx build --platform linux/amd64 -t $(IMAGE_REPO):$$VERSION .

.PHONY: push
push:
	@if [ -z "$$VERSION" ]; then \
		echo "VERSION is required"; \
		exit 1; \
	fi
	docker push $(IMAGE_REPO):$$VERSION

.PHONY: test
test:
	go test -v .

.PHONY: lint
lint:
	docker run --rm -v $$(pwd):/app -w /app golangci/golangci-lint:v1.46.2 golangci-lint run -v
