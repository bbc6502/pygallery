.PHONY: build gallery

.venv:
	python3.13 -m pip install --upgrade virtualenv
	python3.13 -m virtualenv .venv

clean:
	rm -fr .venv

requirements: .venv
	.venv/bin/python -m pip install --upgrade pip -r requirements.txt

build: requirements
	rm -fr dist build
	.venv/bin/python -m build

test-deploy: build
	.venv/bin/python -m twine upload --repository testpypi dist/*

prod-deploy: build
	.venv/bin/python -m twine upload dist/*

test-gallery-build:
	.venv/bin/python -m pygallery build -p photos -o gallery

test-gallery-serve:
	.venv/bin/python -m pygallery serve -p photos -o gallery -P 1080

help:
	.venv/bin/python -m pygallery -h

merge:
	git checkout main
	git merge 0.0.5

tag:
	git tag -a 0.0.5 -m 'Add robots.txt'
