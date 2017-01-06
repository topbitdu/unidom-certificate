##
# Certificating 是参与者和证书之间的认证关系。

class Unidom::Certificate::Certificating < Unidom::Certificate::ApplicationRecord

  self.table_name = 'unidom_certificatings'

  include Unidom::Common::Concerns::ModelExtension

  belongs_to :certificator,  polymorphic: true
  belongs_to :certificated,  polymorphic: true
  belongs_to :certification, polymorphic: true

  scope :certificated_by,  ->(certificator)  { where certificator:  certificator  }
  scope :certificated_is,  ->(certificated)  { where certificated:  certificated  }
  scope :certification_is, ->(certification) { where certification: certification }

  ##
  # 由认证者 certificator 用证书 certification 去认证的人或者机构 certificated ，认证时间是： opened_at。
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
    self.certification_is(certification).certificated_is(certificated).valid_at(now: opened_at).alive.first_or_create! attributes
  end

end
