# Certificating 是参与者和证书之间的认证关系。

class Unidom::Certificate::Certificating < ActiveRecord::Base

  self.table_name = 'unidom_certificatings'

  include Unidom::Common::Concerns::ModelExtension

  belongs_to :certificator,  polymorphic: true
  belongs_to :certificated,  polymorphic: true
  belongs_to :certification, polymorphic: true

  scope :certificated_by,  ->(certificator)  { where certificator:  certificator  }
  scope :certificated_is,  ->(certificated)  { where certificated:  certificated  }
  scope :certification_is, ->(certification) { where certification: certification }

  def self.certificate(certification: nil, certificated: nil, certificator: nil, opened_at: Time.now)
    certificate! certification: certification, certificated: certificated, certificator: certificator, opened_at: opened_at
  end

  def self.certificate!(certification: nil, certificated: nil, certificator: nil, opened_at: Time.now)
    raise ArgumentError.new('The certification argument is required.') if certification.blank?
    raise ArgumentError.new('The certificated argument is required.' ) if certificated.blank?
    raise ArgumentError.new('The opened_at argument is required.'    ) if opened_at.blank?

    attributes = { opened_at: opened_at }
    if certificator.present?
      attributes[:certificator] = certificator
    else
      attributes[:certificator_id]   = Unidom::Common::NULL_UUID
      attributes[:certificator_type] = ''
    end
    self.certification_is(certification).certificated_is(certificated).valid_at.alive.first_or_create! attributes
  end

  class << self
    deprecate certificate: :certificate!, deprecator: ActiveSupport::Deprecation.new('2.0', 'unidom-certificate')
  end

end
