# Unidom Certificate 证书领域模型引擎

[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/unidom-certificate/frames)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](http://opensource.org/licenses/MIT)

[![Gem Version](https://badge.fury.io/rb/unidom-certificate.svg)](https://badge.fury.io/rb/unidom-certificate)
[![Dependency Status](https://gemnasium.com/badges/github.com/topbitdu/unidom-certificate.svg)](https://gemnasium.com/github.com/topbitdu/unidom-certificate)

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



## Disable the Model & Migration

If you only need the app components other than models, the migrations should be neglected, and the models should not be loaded.
```ruby
# config/initializers/unidom.rb
Unidom::Common.configure do |options|

  options[:neglected_namespaces] = %w{
    Unidom::Certificate
  }

end
```



## RSpec examples

### RSpec example manifest (run automatically)

```ruby
# spec/models/unidom_spec.rb
require 'unidom/certificate/models_rspec'

# spec/types/unidom_spec.rb
require 'unidom/certificate/types_rspec'

# spec/validators/unidom_spec.rb
require 'unidom/certificate/validators_rspec'
```

### RSpec shared examples (to be integrated)

```ruby
# The Unidom::Certificate::China::BusinessLicense model, & the Unidom::Certificate::China::IdentityCard model already include the Unidom::Certificate::Concerns::AsCertification concern

# app/models/your_certification.rb
class YourCertification < ApplicationRecord

  include Unidom::Common::Concerns::ModelExtension
  include Unidom::Certificate::Concerns::AsCertification

end

# lib/unidom.rb
def initialize_unidom

  Unidom::Party::Company.class_eval do
    include Unidom::Certificate::Concerns::AsCertificated
  end

  Unidom::Party::Person.class_eval do
    include Unidom::Certificate::Concerns::AsCertificated
  end

  Unidom::Party::Shop.class_eval do
    include Unidom::Certificate::Concerns::AsCertificated
  end

end

# spec/rails_helper.rb
require 'unidom'
initialize_unidom

# spec/support/unidom_rspec_shared_examples.rb
require 'unidom/certificate/rspec_shared_examples'

# spec/models/unidom/party/company_spec.rb
describe Unidom::Party::Company, type: :model do

  model_attribtues = {
    name: 'Tesla'
  }

  it_behaves_like 'Unidom::Certificate::Concerns::AsCertificated', model_attribtues

end

# spec/models/unidom/party/person_spec.rb
describe Unidom::Party::Person, type: :model do

  model_attribtues = {
    name: 'Tim'
  }

  it_behaves_like 'Unidom::Certificate::Concerns::AsCertificated', model_attribtues

end

# spec/models/unidom/party/shop_spec.rb
describe Unidom::Party::Shop, type: :model do

  context do

    model_attribtues = {
      name: 'WalMart'
    }

    certification_attributes = {
      unified_social_credit_identifier: '510105012345678911',
      name:                             'Kaz',
      address:                          'Beijing',
      legal_representative_name:        'Tim'
    }
    certification = Unidom::Certificate::China::BusinessLicense.unified_social_credit_identifier_is(certification_attributes.delete :unified_social_credit_identifier).first_or_create! certification_attributes

    certificator_attributes = {
      name: 'Tim'
    }
    certificator = Unidom::Party::Person.create! certificator_attributes

    it_behaves_like 'Unidom::Certificate::Concerns::AsCertificated', model_attribtues, certification, certificator

  end

end

# spec/models/your_certification_spec.rb
describe YourCertification, type: :model do

  context do

    model_attribtues = {
      name:          'Your Certification Name',
      serial_number: '12345678',
      issued_on:     '2020-01-01'
    }

    it_behaves_like 'Unidom::Certificate::Concerns::AsCertification', model_attribtues

  end

end
```
