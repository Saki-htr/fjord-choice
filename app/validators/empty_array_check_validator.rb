class EmptyArrayCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    record.errors.add(attr_name, :blank, **options) if (value.blank?) && (value != [])
  end
end
