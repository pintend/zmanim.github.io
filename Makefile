all: update deploy

deploy:
	hexo clean
	rm -rf public db.json
	hexo generate
	hexo deploy
