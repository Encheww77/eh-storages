local QBCore = exports['qb-core']:GetCoreObject()

StorageTargets = {}

local promise

CreateThread(function()
  for k, v in pairs(Config.Storages) do
      StorageTargets[k] = exports['qb-target']:AddBoxZone("Storage_".. k, v.coords, v.width, v.length, {
          name = "Storage_".. k,
          heading = v.heading,
          debugPoly = false,
          minZ=v.minZ,
          maxZ=v.maxZ
      }, {
          options = {
          {
              event = "eh-storages:openstorage",
              icon = "fas fa-box",
              label = Lang:t("target.openStorageLabel"),
              id = k,
          },
          {
              event = "eh-storages:changepassword",
              icon = "fas fa-key",
              label = Lang:t("target.changePasswordLabel"),
              id = k,
              canInteract = function()
                QBCore.Functions.TriggerCallback('eh-storages:checkOwner', function(owner)
                    if QBCore.Functions.GetPlayerData().citizenid == owner then
                        promise = true
                    else
                        promise = false
                    end
                end, k)
                return promise
            end
          },
          {
            event = "eh-storages:cancelrent",
            icon = "fas fa-ban",
            label = Lang:t("target.cancelSubscriptionLabel"),
            id = k,
            canInteract = function()
              QBCore.Functions.TriggerCallback('eh-storages:checkOwner', function(owner)
                  if QBCore.Functions.GetPlayerData().citizenid == owner then
                      promise = true
                  else
                      promise = false
                  end
              end, k)
              return promise
          end
        }
      },
          distance = 1.5
      })
  end
end)

RegisterNetEvent('eh-storages:openstorage', function(data)
  QBCore.Functions.TriggerCallback('eh-storages:checkStorage', function(isOwned)
    if isOwned then
        QBCore.Functions.TriggerCallback('eh-storages:isExpired', function(expired)
          if not expired then
            local input = lib.inputDialog(Lang:t("input.storage"), {
              { type = "input", label = Lang:t("input.enterPassword"), password = true, icon = 'lock', required = true, min = 4, max = 16 },
            })
            if input and input[1] then
                QBCore.Functions.TriggerCallback('eh-storages:Checkpassword', function(allowed)
                    if allowed then
                      QBCore.Functions.TriggerCallback('eh-storages:checkTier', function(tiercb)
                        OpenStorage(data.id, tiercb)
                      end, data.id)
                    else
                        Notify(Lang:t("error.wrongPassword"), "error", 5000, false)
                    end
                end, data.id, input[1])
            end
          else
            QBCore.Functions.TriggerCallback('eh-storages:checkOwner', function(owner)
              if QBCore.Functions.GetPlayerData().citizenid == owner then
                local alert = lib.alertDialog({
                  header = 'Поднови наем',
                  content = 'Складът е заключен, защото не е бил платен!  \n  Желаете ли да подновите този склад?  \n  Ако откажете, наемът ще бъде отказан!',
                  centered = true,
                  cancel = true
                })
                if alert == 'confirm' then
                  QBCore.Functions.TriggerCallback('eh-storages:checkTier', function(tiera)
                    QBCore.Functions.TriggerCallback('eh-storages:upDate', function(updated)
                      if updated then
                        Notify('Успешно заплатихте наема!', "success", 5000, false)
                      else 
                        Notify('ERROR', "error", 5000, false)
                      end
                    end, data.id, tiera)
                  end, data.id)
                elseif alert == 'cancel' then
                  QBCore.Functions.TriggerCallback('eh-storages:cancelRent', function(otkazvane)
                    if otkazvane then
                      Notify(Lang:t("success.storageCanceled"), "success", 5000, false)
                    else 
                      Notify('ERROR', "error", 5000, false)
                    end
                  end, data.id)
                end
              else
                Notify(Lang:t("error.expiredStorage"), "error", 5000, false)
              end
            end, data.id)
          end
        end, data.id)
      else
        local alert = lib.alertDialog({
          header = Lang:t("input.buyStorageLabel"),
          content = Lang:t("input.buyStorageDescription"),
          centered = true,
          cancel = true
        })
        if alert == 'confirm' then
          local options = {}

          for k, v in ipairs(Config.Tiers) do
              table.insert(options, { value = k, label = v.name.. " - ".. Lang:t("input.currencySymbol") ..v.price })
          end

          local keyboard = lib.inputDialog(Lang:t("input.options"), {
              { type = "input", label = Lang:t("input.enterPassword"), password = true, icon = 'lock', required = true, min = 4, max = 16 },
              { type = "select", label = Lang:t("input.chooseTier"), options = options, placeholder = Lang:t("input.chooseTier"), required = true },
          })
          if keyboard and keyboard[1] then
              local Password = tostring(keyboard[1])
              local tier = keyboard[2]
              QBCore.Functions.TriggerCallback('eh-storages:buyStorage', function(bought)
                  if bought then
                      promise = true
                      Notify(Lang:t("success.boughtStorage"), "success", 5000, false)
                  end
              end, data.id, QBCore.Functions.GetPlayerData().citizenid, Password, tier)
          end
        end
    end
  end, data.id)
end)

RegisterNetEvent('eh-storages:changepassword', function(data)
    local keyboard = lib.inputDialog(Lang:t("input.passwordLabel"), {
        { type = "input", label = Lang:t("input.newPassword"), password = true, icon = 'lock' },
    })
    if keyboard and keyboard[1] then
        local newPassword = tostring(keyboard[1])
        QBCore.Functions.TriggerCallback('eh-storages:changePassword', function(changed)
            if changed then
              Notify(Lang:t("success.changedPassword"), "warning", 5000, false)
            end
        end, data.id, newPassword)
    end
end)

RegisterNetEvent('eh-storages:cancelrent', function(data)
  local alert = lib.alertDialog({
    header = Lang:t("input.cancelLabel"),
    content = Lang:t("input.cancelDescription"),
    centered = true,
    cancel = true
  })
  if alert == 'confirm' then
    QBCore.Functions.TriggerCallback('eh-storages:cancelRent', function(otkazvane)
      if otkazvane then
        promise = false
        Notify(Lang:t("success.storageCanceled"), "success", 5000, false)
      else 
        Notify('ERROR', "error", 5000, false)
      end
    end, data.id)
  end
end)