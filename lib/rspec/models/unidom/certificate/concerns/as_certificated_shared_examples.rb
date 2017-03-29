shared_examples 'Unidom::Certificate::Concerns::AsCertificated' do |model_attributes, certification, certificator|

  context do

    certificating_1_attribtues = {
        certificator_id:    SecureRandom.uuid,
        certificator_type:  'Unidom::Certificate::Certificator::Mock',
        certification_id:   SecureRandom.uuid,
        certification_type: 'Unidom::Certificate::Certification::Mock'
      }

    certificating_2_attribtues = {
        certificator_id:    SecureRandom.uuid,
        certificator_type:  'Unidom::Certificate::Certificator::Mock',
        certification_id:   SecureRandom.uuid,
        certification_type: 'Unidom::Certificate::Certification::Mock'
      }

    it_behaves_like 'has_many', model_attributes, :certificatings, Unidom::Certificate::Certificating, [ certificating_1_attribtues, certificating_2_attribtues ]

    model = described_class.create! model_attributes
    it_behaves_like 'assert_present!', model, :is_certificated!, [ certification, { by: certificator, at: Time.now } ], [ { 0 => :certification }, :by, :at ]
    it_behaves_like 'assert_present!', model, :is_certificated?, [ certification, {                   at: Time.now } ], [ { 0 => :certification },      :at ]

  end

end
