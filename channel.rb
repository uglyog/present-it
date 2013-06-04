require 'em-websocket'
require 'ap'

EM.run do
  connections = {}
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    ws.onopen do |handshake|
      puts "WebSocket opened #{{
        :path => handshake.path,
        :query => handshake.query,
        :origin => handshake.origin
      }}"

      ws.send "Hello Client!"
    end

    ws.onmessage do |msg|
      match = msg.match /Hi I'm (\w*)/
      if match
        connections[match[1]] = ws
        ap connections
      end

      match = msg.match /(\w*): (.*)/
      if match
        connection = connections[match[1]]
        if connection.nil?
          ws.send("Sorry: #{match[1]} not connected")
        else
          connections[match[1]].send(match[2])
        end
      end
    end
    ws.onclose do
      connections.delete_if { |k, v| v == ws }
      ap connections
    end
    ws.onerror do |e|
      puts "Error: #{e.message}"
      connections.delete_if { |k, v| v == ws }
    end
  end
end