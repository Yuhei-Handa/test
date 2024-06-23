# lintをかける
.PHONY: lint
lint:
	poetry run pysen run lint

# format違反をある程度自動修正する
.PHONY: format
format:
	poetry run pysen run format

.PHONY: test
test:
	poetry run pytest -s -vv ./tests
