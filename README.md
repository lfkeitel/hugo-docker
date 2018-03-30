# Hugo in Docker

**Base Image**: Alpine Edge

**Hugo Version**: 0.37.1

**Github Repository**: https://github.com/lfkeitel/hugo-docker

This is and up-to-date build of [Hugo](https://gohugo.io/) in Alpine.

## Using the Image

Mount your site data to `/site` and just run the container:

```sh
docker run --rm -v $PWD:/site -u $(id -u $USER):$(id -g $USER) lfkeitel/hugo
```

The id pieces are so the created public directory is owned by your own user instead
of root. When using in a multistage build you may not need to worry about file
ownership.
