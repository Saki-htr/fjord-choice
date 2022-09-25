class EmptyArrayCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attr_name, :blank, **options) if value.blank? && (value != [])
  end
end
