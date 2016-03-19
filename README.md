# Unidom Certificate 证书领域模型引擎

[![License](https://img.shields.io/badge/license-MIT-green.svg)](http://opensource.org/licenses/MIT)
[![Gem Version](https://badge.fury.io/rb/unidom-certificate.svg)](https://badge.fury.io/rb/unidom-certificate)

Unidom (UNIfied Domain Object Model) is a series of domain model engines. The Certificate domain model engine includes Identity Card and Business License models.
Unidom (统一领域对象模型)是一系列的领域模型引擎。证书领域模型引擎包括身份证和营业执照的模型。

## Usage in Gemfile
```ruby
gem 'unidom-certificate'
```

## Run the Database Migration
```shell
rake db:migrate
```

## Call the Model
```ruby
officer       = Person.create name: 'John'
mall          = Shop.create   name: 'WalMart'
certification = BusinessLicense.create number: '8888-6666'
certificating = Unidom::Certificate::Certificating.certification_is(certification).certificated_is(mall).valid_at.alive.first_or_create certificator: officer, opened_at: Time.now
```
