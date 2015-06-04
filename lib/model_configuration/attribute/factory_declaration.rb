class ModelConfiguration::Attribute::FactoryDeclaration

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

  def to_s
    "#{attribute.name} { #{data_for_attribute} }"
  end

private

  def data_for_attribute
    case attribute.type
    when "datetime", "date"
      date_data
    when "enum"
      enum_data
    when "string"
      string_data
    else
      raise(ArgumentError, "Unsupported Type: #{attribute.type}")
    end
  end

# Specific Types

  def date_data
    "5.days.from_now"
  end

  def enum_data
    if attribute.properties[:enum_options].present?
      "#{attribute.properties[:enum_options]}.sample"
    else
      raise(ArgumentError, "No enum_options provided for attribute: #{attribute.name}")
    end
  end

  def string_data
    if attribute.name =~ /name/
      "FFaker::Name.name"
    elsif attribute.name =~ /email/
      "FFaker::Internet.email"
    # Guessing since this is a string, it would be phone_number or mobile_number
    elsif attribute.name =~ /number/
      "FFaker::PhoneNumberAU.phone_number"
    else
      "FFaker::Company.bs"
    end
  end

end