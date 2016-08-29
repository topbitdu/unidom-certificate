module Unidom::Certificate::Concerns::AsCertification

  extend ActiveSupport::Concern

  included do |includer|

    has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certification

    def certificate!(certificated, by: nil, at: Time.now)

      raise ArgumentError.new('The certificated argument is required.') if certificated.blank?
      raise ArgumentError.new('The by argument is required.'          ) if by.blank?
      raise ArgumentError.new('The at argument is required.'          ) if at.blank?

      certificatings.create! certificated: certificated, certificator: by, opened_at: at
    end

    def certificate?(certificated, at: Time.now)

      raise ArgumentError.new('The certificated argument is required.') if certificated.blank?
      raise ArgumentError.new('The at argument is required.'          ) if at.blank?

      certificatings.certificated_is(certificated).valid_at(now: at).alive.exists?
    end

  end

end
