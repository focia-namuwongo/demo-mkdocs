# demo-mkdocs
mkdocs project demo

## navigate to project folder (example)
```
cd ~/Documents/focia-projects/demo-mkdocs
```

## to stop the local test server 
press control-C in the terminal 
OR create a new tab in terminal and run the stop command in the new tab
```
make stop
```

## test doc changes and deploy to [dev live site](http://demo-mkdocs-dev-deadly-similarly-relative-blowfish.s3-website-us-east-1.amazonaws.com)
```
make serve env=dev
make deploy env=dev
```

## test doc changes and deploy to [prod live site](http://demo-mkdocs-prod-secondly-centrally-artistic-midge.s3-website-us-east-1.amazonaws.com)
```
make serve env=prod
make deploy env=prod
```

## references
[markdown cheat sheet](https://www.markdownguide.org/cheat-sheet/)  
[git tutorial](https://product.hubspot.com/blog/git-and-github-tutorial-for-beginners)

## troubleshooting

[docker-compose](https://forums.docker.com/t/no-docker-compose-v2-on-macos-13-0-1/131419/9)
[docker-compose](https://stackoverflow.com/questions/36685980/why-is-docker-installed-but-not-docker-compose)