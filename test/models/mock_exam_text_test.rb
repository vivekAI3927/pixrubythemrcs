# == Schema Information
#
# Table name: mock_exam_texts
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class MockExamTextTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
