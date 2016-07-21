module Unidom::Certificate::Concerns::AsCertification

  extend ActiveSupport::Concern

  self.included do |includer|

    has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certification

  end

end
