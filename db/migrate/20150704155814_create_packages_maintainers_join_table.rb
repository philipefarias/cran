class CreatePackagesMaintainersJoinTable < ActiveRecord::Migration
  def change
    create_join_table :packages, :people, table_name: "packages_maintainers" do |t|
      t.index :package_id
      t.index :person_id
    end
  end
end
