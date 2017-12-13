# Validate Precision Number - 0.1
class NumberPrecisionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /\A\d+(?:\.\d{0,1})?\z/.match(value.to_s)
      record.errors[attribute] << (options[:message] || "have a precision of 0.1")
    end
  end
end
