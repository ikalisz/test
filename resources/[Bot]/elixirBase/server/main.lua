
QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- WebHook
logs = {
    ["giriscikis"] = "https://discord.com/api/webhooks/1075116860653178950/hTb3gomqniZm2EEg1uO7rgQkKL188dZ80ts87kHxoW-e-jDDW9mR3kBbRynJta-lhA8O", -- Giriş Çıkış Log
    ["kill"] = "https://discord.com/api/webhooks/989259012493176922/80RDEhI6NULqnKRLrXIdXKeNASin25QDqx-VPWoYz-9TPbFeeAdtyDbair2-DZ4MnzMz",-- Ölme Öldürme Log
    ["hile"] = "https://discord.com/api/webhooks/989259109222187128/UgAJExq7szNN78MOKBfQBIG8cCRnxkgjOEyKyGG6vKTtqS_oN2XJtZMh82_7Ozrp7K8K", -- Hile Log
    ["dupe"] = "https://discord.com/api/webhooks/949285076712165386/GaOeD7ajSR8llDjET1VXx3RpGNNwIDiq4AiTHw0mZmKipVODCpwhXdXGvjQo7Py5PSK1", -- Dupe Log
    ["kara"] = "https://discord.com/api/webhooks/989259239732178954/9KFU709-UzZBLvOjC-d_76Y6POZBLfEMWhqV0zydjUpw4fZCW-BdoRlvDZktFf6iZv5i", -- Kullanılmıyor
    ["black"] = "https://discord.com/api/webhooks/989259294971142295/jl1BWj-Zdf-bWqiBSz-yY9oXQcoxfYOcATATmXe_jZKL91iKGpdygGi3HEKBFo2wn5OF", -- Kullanılmıyor
    ["itemat"] = "https://discord.com/api/webhooks/989259395269545985/icBfB1bGu8TwM1BKGoL79NVpYO-La1nBUx9KtFlGlqs1kyQSAz8iHOLEYaa0ejE8b2WN", -- Yere Eşya Koyma
    ["paratransfer"] = "https://discord.com/api/webhooks/989259473166139465/LUY8qWNscsei0qgOpS4ce_qzIGwdX3t_ZRY2bXjGNkSTZu19lRPPnOQRPN6IcMCUgaR6", -- Para Transfer
    ["aracdevret"] = "https://discord.com/api/webhooks/989259579630157844/1tkFK6J-6C2G_gRZdz8wUSrShyFS6bHh6sQKcVdNhBObi7Ngsv6uydqlsRFCXjaGKWqH", -- Araç Devretme
    ["aracalma"] = "https://discord.com/api/webhooks/989259644138586122/HMV7CsrLaBU2nnczZOZ16VAsvHE524WZsCNa4h5idImBZyrsNCbJDncmqmI5yV4Mr0tw", -- Araç Satın Alma
    ["ikinciel"] = "https://discord.com/api/webhooks/949286404825948220/jDMGV8TC870w_nDCvm3V7QlWEma4rqOXsey0fA5kNGZ373ipS-PWdnEZc8WEvsfX0UzT", -- İkinci El Araç Satın Alma
    ["adminlog"] = "https://discord.com/api/webhooks/989259877522239559/TuNfwu60WK11hSVOAICm2fhyMXgJQa7y8po7kbDFQ7vFeCPs-y12NsWbXlN1CsQAgn4M", -- Adminlog
    ["diger"] = "https://discord.com/api/webhooks/989259946799558717/DqHvh-khOaOoQzcnoKHQaU_c1NPBmVWmY6s0ht4Uiz7MAdTWt-3_wr40lQGzF2ctepo5", -- Diğer ufak tefek polis ems logları
    ["karakterlog"] = "https://discord.com/api/webhooks/989260023416893470/qJ0qyXhlt1gyOb5Dmc8HlFmh3QFtP2mfMayG5YlR-Bf5org87QIDq5qop45eFL3xknW0", -- Karakter Oluşturma Silme
    ["genelchat"] = "https://discord.com/api/webhooks/989260088491520040/zrNYADLLjHtMGczVg1iNUQa4-VM0xanVtLHPrW-vM3FmzhteLUiaPl9Xzkd3uKFpu-q6", -- Chat Log
    ["eventpara"] = "https://discord.com/api/webhooks/949286832577863700/WJfvZCnX6KfO65LQ87nY7qJXpuKnSwQilXHXbfErzTgSlysNwwJhzBqk8qeff1gWD-qR", -- Bazı Eventlerin Para Logu
    ["market"] = "https://discord.com/api/webhooks/949286919995543572/R4Tfogv1tlURF9ySA2to3fyj9p3_Fb_m8asUhv10ZI1PtBIQPtoJGRVzFwDamI4EOQ34", -- Market Eşya Satın Alma
    ["import"] = "https://discord.com/api/webhooks/949287115345260604/QcBs5OE1-otD491hKj_zuYo9sH0P5GaBrGFpAqIHgXjkOjTLhl03WVg2VZxVi-bztMZ6", -- Kullanılmıyor
    ["medo"] = "https://discord.com/api/webhooks/1067553375530537021/i3rTKXGKquEfBGFmBAJ52-ulq-XGHsm80zDDaiEtzOVph6rX5C2oiHlaxPG9LH2NCiy1", -- Me & Do ve OOC 
    ["itemkul"] = "https://discord.com/api/webhooks/1071058270908850216/XLnfHij_rJJ_fDiyydpvdMHL5BJrZM3nTmzaq1mQmxXACr4Iu0AkC4_mbJ0sXMFaI38o", -- İtem Kullanma Log
    ["pceza"] = "https://discord.com/api/webhooks/1055517174858522655/cfqQe5WjGi-H4bDIslxt-v31GmaJ3GgizRXaocOK8Xt7XV4XJHrXEOKDHxDZRxhbMSB7", -- Polis ceza log
    ["pbildirim"] = "https://discord.com/api/webhooks/949287445122396210/aQ_wRaVV__tJdk-FSpYutX-xzYYzWWyWn0_KWtpoLVPxlbNBi7h5KVJ9a-zhEArUwdfe", -- Kullanılmıyor
    ["fatura"] = "https://discord.com/api/webhooks/949287517121814558/-CgHOkSkx9qZlEvEVsN7TS3FL7wbByUhUrwb-9Bip3aqClNLHWBz5nFrcErxSH2u3wXt", -- Fatura Kesme Log
    ["yazarkasa"] = "https://discord.com/api/webhooks/1055275086401249300/39TWOk1Zz7j1KZq4i2piVmSq3wD8_27aH1dRlk6MRDDn__G_RxKGTkRHwGAOoM7SX2TU", -- Yazarkasa Log
    ["hardkasa"] = "https://discord.com/api/webhooks/1055275086401249300/39TWOk1Zz7j1KZq4i2piVmSq3wD8_27aH1dRlk6MRDDn__G_RxKGTkRHwGAOoM7SX2TU", -- Market Arka Kasa Log
    ["evsatinal"] = "https://discord.com/api/webhooks/1067548728510132265/myaOt7JyT4HW63ZRhuJJYPrt9Vkgc8y7YfwMUfM9vQVRrYZbfrJgYBVdUEv-eL7WnRgd", -- Ev Satın Alma Log
    ["isletmesatinal"] = "https://discord.com/api/webhooks/1067555484715978812/CYXMoXd2BTe7paPJdatwRvWDsXTqwOVcF58O28gIzFZSwe6LXCAKcO4qM8SA9VPNBu0t", -- İşletme Satın Alma Log
    ["kosetut"] = "https://discord.com/api/webhooks/1068957024810979389/RqjtH4WisPKa8gl6So1oIxJRlesa-LBfO3KxJN4mTGSJlPaBCQjKetvwMnfkdbRUr5_W", -- Köşetut Log
    ["evsoygunu"] = "https://discord.com/api/webhooks/1072995765238116472/uVmrpH_1-i7iK1OByVkuLMsQmziONrcg0rL2UlHN6R4605GECiQUugeQgnuEd8NprWE2", --Ev Soygunu Log
    ["depoalma"] = "https://discord.com/api/webhooks/1073952240936701952/9bpuEkYchAzjoTXclxyi7yx55csTap4mCJbXGCQ9AnvQz40wVC92YCUZpyZrQu79tO8u", -- Depo Satın Alma Log
    ["seller"] = "https://discord.com/api/webhooks/1082762588850491462/yd11AMVhzN1oeMbEo-mqnRFwefaCMjHHu4ukQu3dnvO4iHQYb_HT25u8p6g08yajWBJY", -- Toptancı Log
    ["banktruck"] = "https://discord.com/api/webhooks/1090357759695925328/kQTZVd6IzNM4sUgZ2YTfHmh3cFrqmadItnK1Tmpip36LI8iSqvfUSCE2NRD3gXxF33cC", -- Toptancı Log
   
}

RegisterServerEvent('DiscordBot:playerDied')
AddEventHandler('DiscordBot:playerDied', function(Message, Weapon, a, b)
	local date = os.date('*t')
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	if a then
		if Message == false then
			local killedPlayer = QBCore.Functions.GetPlayer(source)
			if b == nil then
				b = "IDK"
			end

			TriggerEvent('DiscordBot:ToDiscord', "kill", killedPlayer.PlayerData.charinfo.firstname .. " " ..  killedPlayer.PlayerData.charinfo.lastname ..  " kendi kendine öldü. [" ..b.."] " .. a .. ' `' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`')
		else
			local killedPlayer = QBCore.Functions.GetPlayer(source)
			local killerPlayer = QBCore.Functions.GetPlayer(Message)

			asada = killedPlayer.PlayerData.charinfo.firstname .. " " ..  killedPlayer.PlayerData.charinfo.lastname .. ", " .. killerPlayer.PlayerData.charinfo.firstname .. " " ..  killerPlayer.PlayerData.charinfo.lastname .. " tarafından öldürüldü. [" .. Weapon .. "] " .. a
			TriggerEvent('DiscordBot:ToDiscord', "kill", asada .. ' `' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`')


		end

	else
		if Weapon then Message = Message .. ' [' .. Weapon .. ']' end
		TriggerEvent('DiscordBot:ToDiscord', "kill", Message .. ' `' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`')
	end
end)

RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Message, player, target)
	local msg = ""
	if player then
		local xPlayer = QBCore.Functions.GetPlayer(player)
		if xPlayer then
			msg = xPlayer.PlayerData.citizenid .. " " .. xPlayer.PlayerData.steam .. " " .. xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname .. " **"..Message.."**"
		else
			msg = GetPlayerName(src) ..'('.. GetPlayerIdentifiers(src)[1] ..') [xPlayer Not found!] **'..Message..'**'
		end
		if target then
			local tPlayer = QBCore.Functions.GetPlayer(target)
			if tPlayer then
				msg = msg .. " > " .. tPlayer.PlayerData.citizenid .. " " .. tPlayer.PlayerData.steam .. " " .. tPlayer.PlayerData.charinfo.firstname.. " " ..tPlayer.PlayerData.charinfo.lastname
			else
				msg = msg.. " ".. GetPlayerName(src) ..'('.. GetPlayerIdentifiers(src)[1] ..') [Player Not Found!] '
			end
		end
	else
		msg = Message
	end

	local data = {
		["username"] = "Elixir V1.5",
		["avatar_url"] = "https://media.discordapp.net/attachments/1069231493093785620/1075120629788987392/logo.png",
		["embeds"] = {{
	      ["author"] = {["name"] = "Elixir v1.0 | Log System | ra1der#0710"},
		  ["description"] = msg,
		  ["thumbnail"] = {},
		  ["color"] = 15790574,
		}}

	}

	PerformHttpRequest(logs[WebHook:lower()], function() end, 'POST', json.encode(data), {['Content-Type'] = 'application/json'})
end)

-- Sıra vs sistemi
Queue = {}
Queue.Ready = false
Queue.Exports = nil
Queue.ReadyCbs = {}
Queue.CurResource = GetCurrentResourceName()

if Queue.CurResource == GetCurrentResourceName() then return end

function Queue.OnReady(cb)
    if not cb then return end
    if Queue.IsReady() then cb() return end
    table.insert(Queue.ReadyCbs, cb)
end

function Queue.OnJoin(cb)
    if not cb then return end
    Queue.Exports:OnJoin(cb, Queue.CurResource)
end

function Queue.AddPriority(id, power, temp)
    if not Queue.IsReady() then return end
    Queue.Exports:AddPriority(id, power, temp)
end

function Queue.RemovePriority(id)
    if not Queue.IsReady() then return end
    Queue.Exports:RemovePriority(id)
end

function Queue.IsReady()
    return Queue.Ready
end

function Queue.LoadExports()
    Queue.Exports = exports.connectqueue:GetQueueExports()
    Queue.Ready = true
    Queue.ReadyCallbacks()
end

function Queue.ReadyCallbacks()
    if not Queue.IsReady() then return end
    for _, cb in ipairs(Queue.ReadyCbs) do
        cb()
    end
end

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        while GetResourceState(resource) ~= "started" do Citizen.Wait(0) end
        Citizen.Wait(1)
        Queue.LoadExports()
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        Queue.Ready = false
        Queue.Exports = nil
    end
end)

SetTimeout(1, function() Queue.LoadExports() end)