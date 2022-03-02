class CreatePartaInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_infos do |t|
      t.string :area_tag, :limit => 63
			t.string :heading_info, :limit => 255
      t.text :body_info
      t.timestamps
    end
		parta_info = PartaInfo.create(:area_tag => AREA_TAG_PARTA_REGISTRATION, :heading_info => 'Registration for Part A', :body_info => 'This is for registration of Part A')
		parta_info = PartaInfo.create(:area_tag => AREA_TAG_PARTA_REGISTRATION_COMPLETE, :heading_info => 'Thanks for registering', :body_info => 'Thank you for registering your interest in the Pass the MRCS Part A course. We will be in touch shortly.')
		parta_info = PartaInfo.create(:area_tag => AREA_TAG_PARTA_USER_JOIN_EMAIL, :heading_info => 'Welcome to Pass The MRCS', :body_info => 'Thank you for registering your interest in the Pass the MRCS Part A course. We will be in touch shortly.')
  end
end
