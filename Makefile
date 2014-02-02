build:
	bower install

sync:
	bundle exec rake db:schema:load

.PHONY: build sync
