##
# As Certificated 是被认证参与者的领域关注点。

module Unidom::Certificate::Concerns::AsCertificated

  extend ActiveSupport::Concern

  included do |includer|

    has_many :certificatings, class_name: 'Unidom::Certificate::Certificating', as: :certificated

    ##
    # 被认证者被证书 certification 认证，认证者为 by ，认证时间是 at （缺省为当前时间）。
    # 如： person.is_certificated! mcse, by: bill_gates, at: Time.now
    def is_certificated!(certification, by: nil, at: Time.now)

      raise ArgumentError.new('The certification argument is required.') if certification.blank?
      raise ArgumentError.new('The by argument is required.'           ) if by.blank?
      raise ArgumentError.new('The at argument is required.'           ) if at.blank?

      certificatings.certification_is(certification).valid_at(now: at).alive.first_or_create! certificator: by, opened_at: at

    end

    ##
    # 判断当前被认证者在指定的时间 at (缺省为当前时间)是否有指定的证书 certification 。如：
    # person.is_certificated? mcse, at: Time.now
    def is_certificated?(certification, at: Time.now)

      raise ArgumentError.new('The certification argument is required.') if certification.blank?
      raise ArgumentError.new('The at argument is required.'           ) if at.blank?

      certificatings.certification_is(certification).valid_at(now: at).alive.exists?

    end

  end

  module ClassMethods
  end

end
