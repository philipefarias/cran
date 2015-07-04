require 'rails_helper'

RSpec.describe Package, type: :model do
  context "associations" do
    it { should have_and_belong_to_many(:authors    ).class_name("Person") }
    it { should have_and_belong_to_many(:maintainers).class_name("Person") }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:version) }
    it { should validate_presence_of(:publication) }
  end
end
