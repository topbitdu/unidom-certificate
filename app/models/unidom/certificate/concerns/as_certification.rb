##
# As Certification 是证书的领域关注点。

module Unidom::Certificate::Concerns::AsCertification

  extend ActiveSupport::Concern
  include Unidom::Common::Concerns::ArgumentValidation

  included do |includer|

    has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certification

    ##
    # 用证书去认证参与者（被认证者）。 by 是认证者， at 是认证时间（缺省为当前时间）。
    # 如：mcse.certificate! person, by: bill_gates, at: Time.now
    def certificate!(certificated, by: nil, at: Time.now)

      assert_present! :certificated, certificated
      #raise ArgumentError.new('The certificated argument is required.') if certificated.blank?
      raise ArgumentError.new('The by argument is required.'          ) if by.blank?
      raise ArgumentError.new('The at argument is required.'          ) if at.blank?

      certificatings.certificated_is(certificated).valid_at(now: at).alive.first_or_create! certificator: by, opened_at: at

    end

    ##
    # 判断当前认证书在指定的时间 at (缺省为当前时间)是否对被认证者 certificated 生效。如：
    # mcse.certificated? person, at: Time.now
    def certificate?(certificated, at: Time.now)

      raise ArgumentError.new('The certificated argument is required.') if certificated.blank?
      raise ArgumentError.new('The at argument is required.'          ) if at.blank?

      certificatings.certificated_is(certificated).valid_at(now: at).alive.exists?

    end

  end

  module ClassMethods
  end

end
