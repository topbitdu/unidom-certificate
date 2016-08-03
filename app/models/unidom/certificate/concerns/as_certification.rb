module Unidom::Certificate::Concerns::AsCertification

  extend ActiveSupport::Concern

  self.included do |includer|

    has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certification

    def certificate!(certificated, by: nil, at: Time.now)
      certificatings.create! certificated: certificated, certificator: by, opened_at: at
    end

  end

end
