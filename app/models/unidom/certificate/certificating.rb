# Certificating 是参与者和证书之间的认证关系。

class Unidom::Certificate::Certificating

  self.table_name = 'unidom_certificatings'

  belongs_to :certificator,  polymorphic: true
  belongs_to :certificated,  polymorphic: true
  belongs_to :certification, polymorphic: true

  scope :certificated_by,  ->(certificator)  { where certificator:  certificator  }
  scope :certificated_is,  ->(certificated)  { where certificated:  certificated  }
  scope :certification_is, ->(certification) { where certification: certification }

  include Unidom::Common::Concerns::ModelExtension

end
