# China Identity Card 是中国身份证。

class Unidom::Certificate::ChinaIdentityCard < ActiveRecord::Base

  self.table_name = 'unidom_china_identity_cards'

  validates :name,                   presence: true, length: { in: 2..self.columns_hash['name'].limit                   }
  validates :address,                presence: true, length: { in: 2..self.columns_hash['address'].limit                }
  validates :identification_number,  presence: true, length: { is: self.columns_hash['identification_number'].limit     }
  validates :issuing_authority_name, presence: true, length: { in: 2..self.columns_hash['issuing_authority_name'].limit }

  scope :identification_number_is, ->(identification_number) { where identification_number: identification_number }

end
