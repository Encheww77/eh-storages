local Translations = {

    error = {

        ["expiredStorage"] = "This storage is locked because it has not been paid.",
        ["notEnoughMoney"] = "Not Enough Money",
        ["wrongPassword"] = "Wrong Password",
        ["notifyOwnedStorage"] = "This storage belongs to someone else.",

    },

    success = {

        ["boughtStorage"] = "You have successfully bought this storage.",
        ["changedPassword"] = "You have successfully changed the storage password.",
        ["storageCanceled"] = "You have successfully sold your storage",

    },

    target = {

        ["openStorageLabel"] = "Storage",
        ["changePasswordLabel"] = "Change Password",
        ["cancelSubscriptionLabel"] = "Sell storage",

    },

    input = {

        ["currencySymbol"] = "$",
        ["submitText"] = "Submit",
        ["week"] = "week",
        ["storage"] = "Storage",
        ["options"] = "Options",
        ["enterPassword"] = "Password",
        ["buyStorageLabel"] = "Buy the storage",
        ["chooseTier"] = "Choose Tier",
        ["buyStorageDescription"] = "The storage does not belong to anyone, would you like to buy this storage?  \n  Payments are by bank transfer only!",
        ["cancelLabel"] = "Sell storage",
        ["cancelDescription"] = "Upon selling your storage, you need to pack everything, because you will not recive your items back! Also you will not recive your money back!!!.",
        ["passwordLabel"] = "Change the password",
        ["newPassword"] = "New Password",

    },

}

Lang = Lang or Locale:new({

    phrases = Translations,

    warnOnMissing = true

})
