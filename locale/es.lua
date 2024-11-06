-- I DON'T KNOW IF THIS IS ACCURATE

local Translations = {

    error = {

        ["expiredStorage"] = "Este almacenamiento está bloqueado porque no se ha pagado.",
        ["notEnoughMoney"] = "Hace falta dinero",
        ["wrongPassword"] = "Contraseña incorrecta",
        ["notifyOwnedStorage"] = "Este almacenamiento pertenece a otra persona.",

    },

    success = {

        ["boughtStorage"] = "Has comprado con éxito este almacenamiento.",
        ["changedPassword"] = "Ha cambiado correctamente la contraseña de almacenamiento.",
        ["storageCanceled"] = "Has vendido con éxito tu almacenamiento.",

    },

    target = {

        ["openStorageLabel"] = "Almacenamiento",
        ["changePasswordLabel"] = "Cambiar la contraseña",
        ["cancelSubscriptionLabel"] = "Vender almacenamiento",

    },

    input = {

        ["currencySymbol"] = "$",
        ["submitText"] = "Entregar",
        ["week"] = "semana",
        ["storage"] = "Almacenamiento",
        ["options"] = "Opciones",
        ["enterPassword"] = "Contraseña",
        ["buyStorageLabel"] = "comprar el almacenamiento",
        ["chooseTier"] = "Elija nivel",
        ["buyStorageDescription"] = "El almacenamiento no pertenece a nadie, ¿te gustaría comprar este almacenamiento?  \n  El pago es solo transferencia bancaria!",
        ["cancelLabel"] = "Sell storage",
        ["cancelDescription"] = "Al vender su almacenamiento, debe empacar todo, ¡porque no recibirá sus artículos de vuelta! TAMBIÉN NO RECIBIRÁS TU DINERO!!!.",
        ["passwordLabel"] = "cambiar la contraseña",
        ["newPassword"] = "Nueva contraseña",

    },

}

Lang = Lang or Locale:new({

    phrases = Translations,

    warnOnMissing = true

})
