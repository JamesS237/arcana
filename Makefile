build:
	bower install
	sudo bundle install
	sudo bundle update

sync:
	bundle exec rake db:schema:load

.PHONY: build sync
