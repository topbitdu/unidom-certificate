module Unidom::Certificate::Concerns::AsCertificated

  extend ActiveSupport::Concern

  self.included do |includer|

    has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certificated

    def is_certificated!(certification, by: nil, at: Time.now)
      certificatings.create! certification: certification, certificator: by, opened_at: at
    end

  end

end
