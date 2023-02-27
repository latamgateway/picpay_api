# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem "sorbet-runtime", "~> 0.5.10649"
gem "tapioca", "~> 0.10.5"

group :development, :test do
  gem "sorbet-static", "~> 0.5.10649"
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
