module TestHelpers
  module JsonUtilities
    
    def pretty_json(l, r)
      l = JSON.pretty_generate(JSON.parse(l))
      r = JSON.pretty_generate(JSON.parse(r))
      dbg_json(l, r, false)
    end

    def assert_json(json1, json2, **options)
      assert compare_json(json1, json2, **options)
    end

    private

    def compare_json(json1, json2, **options)
          # TODO: consider moving created_at / updated_at into the caller
      ignored_keys = ["created_at", "updated_at"]
      ignored_keys.concat(options[:ignore]) if options && options[:ignore]
      ignored_keys = ignored_keys.uniq.freeze
      dbg("JSON: ignoring keys: #{ignored_keys.to_s}")

      # TODO: check for these at the end
      once_in_json1 = ignored_keys.dup
      once_in_json2 = ignored_keys.dup

      dbg("I must see these keys at least once in each json: #{once_in_json1.inspect}")
      result, not_once_json1, not_once_json2 = compare_json_inner(json1, json2, ignored_keys, once_in_json1, once_in_json2)

      if not_once_json1.length > 0
        dbg("Ignored keys #{not_once_json1.inspect} were not found in json1.")
        result = false
      end
      if not_once_json2.length > 0
        dbg("Ignored keys #{not_once_json2.inspect} were not found in json2.")
        result = false
      end
      result
    end

    # compares two json objects (Array, Hash, or String to be parsed) for equality
    def compare_json_inner(json1, json2, ignored_keys, once_in_json1, once_in_json2)

      # return false if classes mismatch or don't match our allowed types
      unless((json1.class == json2.class) && (json1.is_a?(String) || json1.is_a?(Hash) || json1.is_a?(Array))) 
        return [false, once_in_json1, once_in_json2]
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
          result = compare_json_inner(json1_obj, json2_obj, ignored_keys, once_in_json1, once_in_json2)
          # End loop once a false match has been found
          dbg_json(json1_obj, json2_obj, result)
          break unless result
        end
      elsif(json1.is_a?(Hash))

        # If a hash, check object1's keys and their values object2's keys and values

        # sanity-check that all ignored keys do actually exist
        json1.each do |key,value|
          if once_in_json1.include?(key)
            dbg("found ignored key in json1: #{key}")
            once_in_json1.delete(key)
          end
        end
        json2.each do |key,value|
          if once_in_json2.include?(key)
            dbg("found ignored key in json2: #{key}")
            once_in_json2.delete(key)
          end
        end

        # created_at and updated_at (etc.) can create false mismatches in tests
        [json1,json2].each do |json|
          json.delete_if do |key,value|
            ignored_keys.include?(key)
          end
        end

        json1.each do |key,value|
          # both objects must have a matching key to pass
          unless json2.has_key?(key)
            dbg("json1.has_key?(#{key}) = true but json2.has_key?(#{key}) = false")
            return [false, once_in_json1, once_in_json2]
          end

          json1_val, json2_val = value, json2[key]

          if(json1_val.is_a?(Array) || json1_val.is_a?(Hash))
            # If value of key is an array or hash, recursively call self with these objects to traverse deeper
            result = compare_json_inner(json1_val, json2_val, ignored_keys, once_in_json1, once_in_json2)
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
            return [false, once_in_json1, once_in_json2]
          end
        end
      end

      dbg_json_mismatch(result)
      if result
        return [true, once_in_json1, once_in_json2]
      else
        return [false, once_in_json1, once_in_json2]
      end
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

  end
end
