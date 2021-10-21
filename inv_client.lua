require 'inv_common'

function serverCall(serverID, func, args)
    rednet.send(serverID, {func, args})
    while true do
        -- TODO: Properly utilize coroutines
        id, message = rednet.receive(PROTOCOL)
        if id == serverID then
            return message
        end
    end
end

rednet.open(getModemSide())
while true do
    func = read()
    args = textutils.unserialize(read())
    print(textutils.serialize(serverCall(0,func,args)))
end
rednet.close(getModemSide())