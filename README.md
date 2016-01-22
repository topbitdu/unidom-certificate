# Unidom Certificate

Unidom (UNIfied Domain Object Model) is a series of domain model engines. The Certificate domain model engine includes Identity Card and Business License models.
Unidom (统一领域对象模型)是一系列的领域模型引擎。证书领域模型引擎包括身份证和营业执照的模型。

## Usage in Gemfile:
```ruby
gem 'unidom-certificate'
```

## Run the Database Migration:
```shell
rake db:migrate
```

## Call the Model:
```ruby
Unidom::Certificate::Certificating.valid_at.alive.first
```
