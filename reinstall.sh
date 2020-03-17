#! /bin/sh

gem uninstall haml-contrib

rm haml-contrib-1.0.0.1.gem




gem build haml-contrib.gemspec
gem install haml-contrib