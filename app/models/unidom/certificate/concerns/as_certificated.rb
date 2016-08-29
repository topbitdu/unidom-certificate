module Unidom::Certificate::Concerns::AsCertificated

  extend ActiveSupport::Concern

  included do |includer|

    has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certificated

    def is_certificated!(certification, by: nil, at: Time.now)

      raise ArgumentError.new('The certification argument is required.') if certification.blank?
      raise ArgumentError.new('The by argument is required.'           ) if by.blank?
      raise ArgumentError.new('The at argument is required.'           ) if at.blank?

      certificatings.create! certification: certification, certificator: by, opened_at: at

    end

    def is_certificated?(certification, at: Time.now)

      raise ArgumentError.new('The certification argument is required.') if certification.blank?
      raise ArgumentError.new('The at argument is required.'           ) if at.blank?

      certificatings.certification_is(certification).valid_at(now: at).alive.exists?

    end

  end

end
