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

    raise ArgumentError.new('certification is required.') if certification.blank?
    raise ArgumentError.new('certificated is required.')  if certificated.blank?

    self.certification_is(certification).certificated_is(certificated).valid_at.alive.first_or_create! opened_at: opened_at,
      certificator_id:   (certificator.present? ? certificator.id         : Unidom::Common::NULL_UUID),
      certificator_type: (certificator.present? ? certificator.class.name : '')

  end

end
