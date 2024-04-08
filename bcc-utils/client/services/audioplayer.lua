YtAudioPlayer = {}

function YtAudioPlayer.PlayAudio(embedlink, videoid, volume, loop)
    SendNUIMessage({
        type = 'open',
        embedlink = embedlink,
        videoid = videoid,
        loop = loop,
        volume = volume
    })
end

function YtAudioPlayer.StopAudio()
    SendNUIMessage({
        type = 'close'
    })
end