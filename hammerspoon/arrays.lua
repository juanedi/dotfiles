arrays = {}


-- arrays.find({"a", "b", "c"}, function(x)
--   x == "b"
-- ) ~~~> 2
function arrays.find(array, predicate)
  for i,v in ipairs(array) do
    if predicate(v) then
      return i
    end
  end

  return nil
end

-- arrays.select_first({"a", "bb", "c", "dd"}, function(s)
--  string.len(s) == 2
-- ) ~~~> 2
function arrays.select_first(array, predicate)
  for i,v in ipairs(array) do
    if predicate(v) then
      return v
    end
  end

  return nil
end

-- arrays.contains({1, 2, 3}, 2) ~~~> true
function arrays.contains(array, value)
  for _,v in ipairs(array) do
    if value == v then
      return true
    end
  end

  return false
end

-- arrays.from_range(2, 5) ~~~> {2, 3, 4, 5}
function arrays.from_range(i, j)
  result = {}

  for x=i,j do
    table.insert(result, x)
  end

  return result
end

-- arrays.concat({2,3}, {1, 4}) ~~~> {2, 3, 1, 4}
function arrays.concat(array1, array2)
  result = {}

  for _,v in ipairs(array1) do
    table.insert(result, v)
  end

  for _,v in ipairs(array2) do
    table.insert(result, v)
  end

  return result
end

return arrays
