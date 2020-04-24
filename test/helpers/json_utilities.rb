module JsonUtilities
  
  # compares two json objects (Array, Hash, or String to be parsed) for equality
  def compare_json(json1, json2, **options)
    # TODO: consider moving created_at / updated_at into the caller
    ignored_keys = ["created_at", "updated_at"]
    ignored_keys.concat(options[:ignore]) if options && options[:ignore]
    ignored_keys = ignored_keys.uniq.freeze
    dbg("JSON: ignoring keys: #{ignored_keys.to_s}")

    # TODO: check for these at the end
    at_least_once_keys = ignored_keys.dup

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
        dbg_json(json1_obj, json2_obj, result)
        break unless result
      end
    elsif(json1.is_a?(Hash))

      # If a hash, check object1's keys and their values object2's keys and values

      # created_at and updated_at (etc.) can create false mismatches in tests
      [json1,json2].each do |json|
        json.delete_if do |key,value|
          ignored_keys.include?(key)
        end
      end

      # sanity-check that all ignored keys do actually exist
      [json1,json2].each do |json|
        json.each do |key,value|
          at_least_once_keys.delete(key) if json[key]
        end
      end

      json1.each do |key,value|
        # both objects must have a matching key to pass
        unless json2.has_key?(key)
          dbg("json1.has_key?(#{key}) = true but json2.has_key?(#{key}) = false")
          return false
        end

        json1_val, json2_val = value, json2[key]

        if(json1_val.is_a?(Array) || json1_val.is_a?(Hash))
          # If value of key is an array or hash, recursively call self with these objects to traverse deeper
          result = compare_json(json1_val, json2_val, **{ignore: ignored_keys})
          dbg_json(json1_val, json2_val, result)
        else
          result = (json1_val == json2_val)
          dbg_json(json1_val, json2_val, result)
        end

        # End loop once a false match has been found
        unless result
          dbg_json(json1, json2, result)
          break 
        end
      end

      json2.each do |key,value|
        # both objects must have a matching key to pass
        unless json1.has_key?(key)
          dbg("json1.has_key?(#{key}) = false but json2.has_key?(#{key}) = true")
          return false
        end
      end
    end

    dbg_json_mismatch(result)
    return result ? true : false
  end

  def assert_json(json1, json2, **options)
    assert compare_json(json1, json2, **options)
  end

  def dbg(msg)
    puts msg if ENV['VERBOSE']
  end

  def dbg_json_mismatch(result)
    dbg "JSON: Found Mismatch." unless result
  end

  def dbg_json(l, r, result=false)
    unless result
      dbg "JSON: \n'#{l}' \n    NOT EQUAL TO \n'#{r}'"
    end
  end

  def pretty_json(l, r)
    l = JSON.pretty_generate(JSON.parse(l))
    r = JSON.pretty_generate(JSON.parse(r))
    dbg_json(l, r, false)
  end
end
