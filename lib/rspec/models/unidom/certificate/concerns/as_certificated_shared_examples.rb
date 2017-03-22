shared_examples 'Unidom::Certificate::Concerns::AsCertificated' do |model_attributes|

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

  end

end
