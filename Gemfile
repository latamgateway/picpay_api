# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gemspec

gem "sorbet-runtime", "~> 0.5.10649"

group :development, :test do
  gem "rspec", "~> 3.12"
  gem "factory_bot", "~> 6.2"
  gem "dotenv", "~> 2.8"
  gem "pry-byebug", "~> 3.10"
end

group :development do
  gem "sorbet-static", "~> 0.5.10649"
  gem "yard", "~> 0.9.28"
end

group :test do
end
