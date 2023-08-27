Config.Languages["en"] = {
    ["notifications"] = {
        -- Bank
        ["selftransfer"] = "You can't send yourself money!",
        ["selfrequest"] = "You can't ask for money!",
        ["receivedmoney"] = "<strong>{senderId}</strong> by <strong>{amount}$</strong> You received a transfer in the amount! Reason: <strong>{reason}</strong>",
        ["requestedmoney"] = "<strong>{requesterName} [{requesterId}]</strong> from you <strong>{amount}$</strong> asked for money in the amount!Reason: <strong>{reason}</strong>",
        ["receivernonexistant"] = "User with this identity is not available!",
        ["notenoughmoney"] = "You don't have enough money to do this!",
        ["requestdoesntexist"] = "No request is available!",
        ["requestcooldown"] = "You can't send such a quick request!",
        ["transfercooldown"] = "You cannot send such a quick transfer request!",
        ["playernotonline"] = "The player with this identity is not online!",
        ["playernotonlineanymore"] = "The player's connection with the server was cut off!",
        -- Phone
        ["userbusy"] = "Person busy!",
        ["usernotavailable"] = "The person cannot be reached!",
        ["noavailableunits"] = "There is no suitable unit to answer the search!",
        -- Twitter/mail
        ["accountdoesntexist"] = "E-mail address is not registered!",
        ["emailtaken"] = "E-mail has already been taken!",
        ["usernametaken"] = "Username already taken!",
        ["userdoesntexist"] = "The user is not available!",
        ["wrongpassword"] = "Wrong password!",
        ["wrongresetcode"] = "Wrong code!",
        -- Dark chat
        ["invitedoesntexist"] = "The invitation code is not available!",
        ["alreadyingroup"] = "You are already in the group!",
        ["bannedfromgroup"] = "You are banned from this group!",
        ["groupmemberlimitreached"] = "Group Members Number Limit Exceeded!",
        ["member_joined"] = "<strong>{memberName}</strong> joined the group",
        ["member_left"] = "<strong>{memberName}</strong> left the group",
        ["member_banned"] = "<strong>{memberName}</strong> banned from the group",
        ["member_kicked"] = "<strong>{memberName}</strong> thrown from the group",
    },
    -- Other
    ["open_phone"] = "Pick up the phone",
    ["deleted_user"] = "Deleted user",
    ["unknown"] = "Unknown",
    ["unknown_caller"] = "Unknown seeking",
    ["newtweetwebhook"] = {
        ["title"] = "📢 New Tweet from {senderTwitterName} ({senderName} [**{senderId}**])!",
        ["replying"] = "Replying to @{tweeterName}",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["tweetreportwebhook"] = {
        ["title"] = "📢 Tweet with ID {tweetId} posted by {tweeterName} was reported by {reporterTwitterName} ({reporterName} [**{reporterId}**])!",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newmailwebhook"] = {
        ["title"] = "📧 New Mail from **{senderMailAddress}** ({senderName} [**{senderId}**])!",
        ["description"] = "To **{recipients}**\nSubject: **{subject}**\nContent: **{content}**",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newadwebhook"] = {
        ["title"] = "📢 New Advertisment from **{senderFullname}** ({senderName} **{senderId}**)!",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newtransactionwebhook"] = {
        ["title"] = "💸 **New transaction**",
        ["description"] = "From player **{senderName}** [**{senderId}**] to **{receiverName}** [**{receiverId}**]\nTransaction reason: **{reason}**\nAmount: **{amount} €**",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["twitterresetmail"] = {
        ["senderAddress"] = "noreply@twitter.com",
        ["senderName"] = "Twitter",
        ["senderPhoto"] = "media/icons/twitter.png",
        ["subject"] = "Account reset",
        ["content"] = "Hello, <br> <br> We found the information of his stolen account!The code required to reset the password of your account is here!<br><br><strong>{resetCode}</strong><div class='footer twt'>@ 2023 Twitter.com. All rights reserved.</div>"
    }
}