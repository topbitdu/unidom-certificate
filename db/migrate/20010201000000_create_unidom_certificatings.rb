class CreateUnidomCertificatings < ActiveRecord::Migration

  def change

    create_table :unidom_certificatings, id: :uuid do |t|

      t.references :certificator,  type: :uuid, null: false,
        polymorphic: { null: false, default: '', limit: 200 }
      t.references :certificated,  type: :uuid, null: false,
        polymorphic: { null: false, default: '', limit: 200 }
      t.references :certification, type: :uuid, null: false,
        polymorphic: { null: false, default: '', limit: 200 }

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false
      t.jsonb    :notation,         null: false, default: {}

      t.timestamps null: false

    end

    add_index :unidom_certificatings, :certificator_id
    add_index :unidom_certificatings, :certificated_id
    add_index :unidom_certificatings, :certification_id

  end

end
