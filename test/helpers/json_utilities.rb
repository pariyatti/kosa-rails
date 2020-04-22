module JsonUtilities
# compares two json objects (Array, Hash, or String to be parsed) for equality
  def compare_json(json1, json2, **options)
    ignored_keys = ["created_at", "updated_at"]
    ignored_keys.concat(options[:ignore]) if options && options[:ignore]
    ignored_keys = ignored_keys.uniq
    puts "JSON: ignoring keys: #{ignored_keys.to_s}"

    # return false if classes mismatch or don't match our allowed types
    unless((json1.class == json2.class) && (json1.is_a?(String) || json1.is_a?(Hash) || json1.is_a?(Array))) 
      return false
    end

    # initializing result var in the desired scope
    result = false

    # Parse objects to JSON if Strings
    json1,json2 = [json1,json2].map! do |json|
      json.is_a?(String) ? JSON.parse(json) : json
    end

    # If an array, loop through each subarray/hash within the array and recursively call self with these objects for traversal
    if(json1.is_a?(Array))
      json1.each_with_index do |obj, index|
        json1_obj, json2_obj = obj, json2[index]
        result = compare_json(json1_obj, json2_obj, **{ignore: ignored_keys})
        # End loop once a false match has been found
        debug_json(json1_obj, json2_obj, result)
        break unless result
      end
    elsif(json1.is_a?(Hash))

      # If a hash, check object1's keys and their values object2's keys and values

      # created_at and updated_at can create false mismatches due to occasional millisecond differences in tests
      [json1,json2].each do |json|
        json.delete_if do |key,value|
          ignored_keys.include?(key)
        end
      end

      json1.each do |key,value|

        # both objects must have a matching key to pass
        unless json2.has_key?(key)
          debug_json("json1.has_key?(#{key}) = true", "json2.has_key?(#{key}) = false", result)
          return false
        end

        json1_val, json2_val = value, json2[key]

        if(json1_val.is_a?(Array) || json1_val.is_a?(Hash))
          # If value of key is an array or hash, recursively call self with these objects to traverse deeper
          result = compare_json(json1_val, json2_val, **{ignore: ignored_keys})
          debug_json(json1_val, json2_val, result)
        else
          result = (json1_val == json2_val)
          debug_json(json1_val, json2_val, result)
        end

        # End loop once a false match has been found
        unless result
          debug_json(json1, json2, result)
          break 
        end
      end
    end

    debug_json_mismatch(result)
    return result ? true : false
  end

  def debug_json_mismatch(result)
    puts "JSON: Found Mismatch." unless result
  end

  def debug_json(l, r, result=false)
    unless result
      puts "JSON: '#{l}' \n    NOT EQUAL TO \n'#{r}'"
    end
  end
end
