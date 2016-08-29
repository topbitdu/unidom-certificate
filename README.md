# Unidom Certificate 证书领域模型引擎

[![License](https://img.shields.io/badge/license-MIT-green.svg)](http://opensource.org/licenses/MIT)
[![Gem Version](https://badge.fury.io/rb/unidom-certificate.svg)](https://badge.fury.io/rb/unidom-certificate)

Unidom (UNIfied Domain Object Model) is a series of domain model engines. The Certificate domain model engine includes Identity Card and Business License models.
Unidom (统一领域对象模型)是一系列的领域模型引擎。证书领域模型引擎包括身份证和营业执照的模型。

## Recent Update
Check out the [Road Map](ROADMAP.md) to find out what's the next.
Check out the [Change Log](CHANGELOG.md) to find out what's new.

## Usage in Gemfile
```ruby
gem 'unidom-certificate'
```

## Run the Database Migration
```shell
rake db:migrate
```
The migration versions start with 200102.

## Call the Model
```ruby
officer       = Unidom::Party::Person.create! name: 'John'
mall          = Unidom::Party::Shop.create!   name: 'WalMart'
certification = Unidom::Certificate::China::BusinessLicense.registration_number_is('123456789012345').valid_at.alive.first_or_create! name: 'WalMart', address: 'Beijing', legal_representative_name: 'Tim' 
certificating = Unidom::Certificate::Certificating.certificate!(certification: certification, certificated: mall, certificator: officer, opened_at: Time.now)
```

## Include the Concerns
```ruby
include Unidom::Certificate::Concerns::AsCertificated
include Unidom::Certificate::Concerns::AsCertification
```

### As Certificated concern
The As Certificated concern do the following tasks for the includer automatically:
1. Define the has_many :certificatings macro as: ``has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certificated``
2. Define the #is_certificated! method as: ``def is_certificated!(certification, by: nil, at: Time.now)``
3. Define the #is_certificated? method as: ``def is_certificated?(certification, at: Time.now)``

### As Certification concern
The As Certification concern do the following tasks for the includer automatically:
1. Define the has_many :certificatings macro as: ``has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certification``
2. Define the #certificate! method as: ``def certificate!(certificated, by: nil, at: Time.now)``
3. Define the #certificate? method as: ``def certificate?(certificated, at: Time.now)``
