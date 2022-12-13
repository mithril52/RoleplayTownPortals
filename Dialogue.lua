if not RTP then RTP = { } end
if not RTP.UTIL then RTP.UTIL = { } end

function RTP.OnChatterBegin()
    local interactionType = GetInteractionType()
    
    d(string.format("OnChatterBegin(): InteractionType = %i", interactionType))
end 