function PlayAudio(url, volume)
	TriggerClientEvent('events:playAudio', -1, url, volume)
end

function PauseAudio()
	TriggerClientEvent('events:pauseAudio', -1, url)
end

function PlayVideo(url, volume, width, height, left, top, opacity)
	TriggerClientEvent('events:playVideo', -1, url, volume, width, height, left, top, opacity)
end

function PauseVideo()
	TriggerClientEvent('events:pauseVideo', -1)
end

function ScreenFadeOut(duration)
	TriggerClientEvent('events:screenFadeOut', -1, duration)
end

function ScreenFadeIn(duration)
	TriggerClientEvent('events:screenFadeIn', -1, duration)
end

function AnimpostfxPlay(effectName)
	TriggerClientEvent('events:animpostfxPlay', -1, effectName)
end

function AnimpostfxStop(effectName)
	TriggerClientEvent('events:animpostfxStop', -1, effectName)
end

exports('playAudio', PlayAudio)
exports('pauseAudio', PauseAudio)
exports('playVideo', PlayVideo)
exports('pauseVideo', PauseVideo)
exports('screenFadeOut', ScreenFadeOut)
exports('screenFadeIn', ScreenFadeIn)
exports('animpostfxPlay', AnimpostfxPlay)
exports('animpostfxStop', AnimpostfxStop)
