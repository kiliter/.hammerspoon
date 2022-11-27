module = {}

module.notify = function (title,content)
   local img = hs.image.imageFromName(hs.image.systemImageNames.User)
   local n = hs.notify.new({
        title=title, 
        informativeText=content,
        soundName="Blow",
        autoWithdraw=true, 
        alwaysShowAdditionalActions=true,
        withdrawAfter=4})
        print(n:activationType())
        n:send()
end

return module