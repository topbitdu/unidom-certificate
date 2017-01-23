describe Unidom::Certificate::Certificating, type: :model do

  before :each do
  end

  after :each do
  end

  context do

    model_attributes = {
      certificator_id:    SecureRandom.uuid,
      certificator_type:  'Unidom::Certificate::Certificator::Mock',
      certificated_id:    SecureRandom.uuid,
      certificated_type:  'Unidom::Certificate::Certificated::Mock',
      certification_id:   SecureRandom.uuid,
      certification_type: 'Unidom::Certificate::Certification::Mock'
    }

    it_behaves_like 'Unidom::Common::Concerns::ModelExtension', model_attributes

  end

end
