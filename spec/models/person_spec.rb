require 'rails_helper'

RSpec.describe Person, type: :model do
  context "associations" do
    it { should have_and_belong_to_many(:authored_packages  ).class_name("Package") }
    it { should have_and_belong_to_many(:maintained_packages).class_name("Package") }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end
end
