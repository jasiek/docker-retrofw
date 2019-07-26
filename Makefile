build:
	docker build -t jasiek/retrofw .

push:	build
	docker push jasiek/retrofw

