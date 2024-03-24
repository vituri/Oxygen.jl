module WebSocketDemo
using HTTP
using HTTP.WebSockets: send

include("../src/Oxygen.jl")
using .Oxygen

@get "/" function()
    text("hello world")
end


@get "/math/{a}/{b}" function(req, a::Float64, b::Float64;)
    text("$(a * b)")
end

@ws "/ws" function(ws::HTTP.WebSocket; request::HTTP.Request)
    println(">> req: $request")
    for msg in ws
        @info "Received message: $msg"
        send(ws, msg)
    end
end

@ws "/ws/{x}" function(ws::HTTP.WebSocket, x::Int; request)
    println(">> init req: $request")

    println("Connected to websocket with x = $x")
    for msg in ws
        @info "Received message from $x: $msg"
        send(ws, msg)
    end
end

serve(access_log=nothing)



end