# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_type :string
#  commentable_id   :integer
#  admin_id         :integer
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  # belongs_to :user
  belongs_to :admin
end
