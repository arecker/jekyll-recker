# frozen_string_literal: true

# Integer extensions
class Integer
  def pretty
    JekyllRecker::Utils.prettify_number(self)
  end
end

# String extensions
class String
  def words
    JekyllRecker::Utils.to_word_list(self)
  end

  def word_count
    JekyllRecker::Utils.to_word_list(self).count
  end

  def pretty_path(home = nil)
    JekyllRecker::Utils.prettify_path(self, home)
  end

  def to_and_array
    JekyllRecker::Utils.and_list_to_array(self)
  end
end

# Array extensions
class Array
  def to_and_list
    JekyllRecker::Utils.array_to_and_list(self)
  end

  def to_weighted_list
    JekyllRecker::Utils.to_weighted_list(self)
  end
end
