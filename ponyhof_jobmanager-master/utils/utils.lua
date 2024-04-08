function has_value (tab, val)
  for index, value in ipairs(tab) do
      if value == val then
          return true
      end
  end

  return false
end

function log(x)
  print("^5[ponyhof-jobmanager]^0 " .. x)
end

function logError(x)
  print("^5[ponyhof-jobmanager]^1 " .. x .. "^0")
end