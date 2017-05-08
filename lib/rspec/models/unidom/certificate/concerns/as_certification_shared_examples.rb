shared_examples 'Unidom::Certificate::Concerns::AsCertification' do |model_attributes, model, certificated, certificator|

  #subject do described_class.create! model_attributes end
  #it '#certificate!' do
    it_behaves_like 'assert_present!', model, :certificate!, [ certificated, { by: certificator, at: Time.now } ], [ { 0 => :certificated }, :by, :at ]
  #end
  #it '#certificate?' do
    it_behaves_like 'assert_present!', model, :certificate?, [ certificated, {                   at: Time.now } ], [ { 0 => :certificated },      :at ]
  #end

  context do

    certificating_1_attribtues = {
        certificator_id:   SecureRandom.uuid,
        certificator_type: 'Unidom::Certificate::Certificator::Mock',
        certificated_id:   SecureRandom.uuid,
        certificated_type: 'Unidom::Certificate::Certificated::Mock'
      }

    certificating_2_attribtues = {
        certificator_id:   SecureRandom.uuid,
        certificator_type: 'Unidom::Certificate::Certificator::Mock',
        certificated_id:   SecureRandom.uuid,
        certificated_type: 'Unidom::Certificate::Certificated::Mock'
      }

    it_behaves_like 'has_many', model_attributes, :certificatings, Unidom::Certificate::Certificating, [ certificating_1_attribtues, certificating_2_attribtues ]

  end

  context do

    #model = described_class.create! model_attributes
    #it_behaves_like 'assert_present!', model, :certificate!, [ certificated, { by: certificator, at: Time.now } ], [ { 0 => :certificated }, :by, :at ]
    #it_behaves_like 'assert_present!', model, :certificate?, [ certificated, {                   at: Time.now } ], [ { 0 => :certificated },      :at ]

  end

end
