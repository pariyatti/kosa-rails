module Neo4j
# Converts DateTime objects to and from Java long types. Must be timezone UTC.
class SaneDateTimeConverter # < BaseConverter
  class << self
    def convert_type
      DateTime
    end

    def db_type
      Integer
    end

    # Converts the given DateTime (UTC) value to an Integer.
    # DateTime values are automatically converted to UTC.
    def to_db(value)
      value = value.new_offset(0) if value.respond_to?(:new_offset)

      args = [value.year, value.month, value.day]
      args += (value.class == Date ? [0, 0, 0, 0] : [value.hour, value.min, value.sec, value.usec])

      Time.utc(*args).strftime("%Y-%m-%d %H:%M:%S.%9N UTC")
    end

    def to_ruby(value)
      return value if value.is_a?(DateTime)
      t = case value
          when Time
            return value.to_datetime.utc
          when Integer
            Time.at(value).utc
          when String
            return value.to_datetime
          else
            fail ArgumentError, "Invalid value type for DateType property: #{value.inspect}"
          end

      DateTime.civil(t.year, t.month, t.day, t.hour, t.min, t.sec, t.usec)
    end
  end

  include Neo4j::Shared::Typecaster
end
end
