class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    
    value = case attribute
      when :default_email then value.email
      when :email         then value
    end

    if !has_valid_format?(value)
      record.errors[:email] << (options[:message] || "has wrong format")
      return false
    end
    
    if !is_unique?(record, value)
      record.errors[:email] << (options[:message] || "email already been taken")
      return false
    end

  end

  def has_valid_format? value
    value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ? true : false
  end

  def is_unique? record, value
    emails = Email.where(email: value)
    if emails.count > 0
      (emails.count == 1 && record.id == emails.first.id) ? true : false
    else
      true
    end
  end

end