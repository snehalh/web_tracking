class WebTrackingDetailsTest < Neo4j::Migrations::Base
  def up
    rename_property :WebTrackingDetailsTest, :title, :first_name
  end

  def down
    rename_property :WebTrackingDetailsTest, :title, :first_name
  end
end
