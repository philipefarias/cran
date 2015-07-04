require 'rails_helper'

RSpec.describe Package, type: :model do
  context "associations" do
    it { should have_and_belong_to_many(:authors    ).class_name("Person") }
    it { should have_and_belong_to_many(:maintainers).class_name("Person") }
  end

  context "validations" do
    subject { Package.new name: "Dummy", version: "0.0.1", publication: Date.today }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:version) }
    it { should validate_presence_of(:publication) }

    it { should validate_uniqueness_of(:version).scoped_to(:name) }
  end
end
