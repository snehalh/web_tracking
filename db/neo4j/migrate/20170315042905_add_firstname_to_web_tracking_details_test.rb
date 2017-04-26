class AddFirstnameToWebTrackingDetailsTest < Neo4j::Migrations::Base
  def up
    add_column :WebTrackingDetailsTest, :firstname, :String
  end

  def down
    raise Neo4j::IrreversibleMigration
  end
end
