class CreateEndUserLicenseAgreements < ActiveRecord::Migration[6.0]
  def change
    create_table :end_user_license_agreements do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
