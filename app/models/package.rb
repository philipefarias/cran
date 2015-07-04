class Package < ActiveRecord::Base
  has_and_belongs_to_many :authors,     class_name: "Person", join_table: "packages_authors"
  has_and_belongs_to_many :maintainers, class_name: "Person", join_table: "packages_maintainers"

  validates :name, :version, :publication, presence: true
end
