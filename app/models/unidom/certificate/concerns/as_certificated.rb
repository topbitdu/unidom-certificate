module Unidom::Certificate::Concerns::AsCertificated

  extend ActiveSupport::Concern

  self.included do |includer|

    has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certificated

  end

end
