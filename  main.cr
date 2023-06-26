require "http/server"
require "./travel_plan_controller"

server = HTTP::Server.new do |context|
  TravelPlanController.new(context).dispatch
end

puts "Server listening on http://localhost:3000"
server.listen(3000)
