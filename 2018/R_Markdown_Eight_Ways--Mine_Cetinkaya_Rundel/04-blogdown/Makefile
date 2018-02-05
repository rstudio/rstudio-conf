REMOTEUSER ?= mc301
HOST ?= okeeffe.stat.duke.edu
DIR ?= /web/isds/docs/courses/Spring18/Sta199
REMOTE ?= $(REMOTEUSER)@$(HOST):$(DIR)

.PHONY: clean
clean:
	rm -rf docs/*

push:
	cp favicon.ico docs/
	rsync -azv --delete  --exclude='.DS_Store'  docs/ $(REMOTE)

unbind:
	lsof -wni tcp:4000

serve:
	hugo server --watch
