# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :development, :test do
  gem "tapioca", "~> 0.10.5"
  gem "dotenv", "~> 2.8"
  gem "pry-byebug", "~> 3.10"
end

group :development do
  gem "yard", "~> 0.9.28"
end

group :test do
  gem "rspec", "~> 3.12"
  gem "factory_bot", "~> 6.2"
  gem "webmock", "~> 3.18"
end
