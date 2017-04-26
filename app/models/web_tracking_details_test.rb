class WebTrackingDetailsTest 
  include Neo4j::ActiveNode
  property :title
  property :score, type: Integer, default: 0
end
