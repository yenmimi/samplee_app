source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.3"

gem "bcrypt"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-kaminari-views"
gem "bootstrap-sass", "3.3.7"
gem "carrierwave", "1.2.2"
gem "config"
gem "faker", "~> 1.9", ">= 1.9.3"
gem "i18n"
gem "jbuilder", "~> 2.5"
gem "jquery-rails", "~> 4.3", ">= 4.3.3"
gem "kaminari"
gem "mini_magick", "4.7.0"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.2"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "sqlite3", "~> 1.3.6"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :production do
  gem "fog", "1.42"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
