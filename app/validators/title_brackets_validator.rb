class TitleBracketsValidator < ActiveModel::Validator
  BRACKET_PAIRS = {
      '(' => ')',
      '[' => ']',
      '{' => '}'
  }

  def validate(record)
    return if record.title.empty?

    brackets_stack = []
    last_step_opened_bracket = false
    record.title.split('').each do |sym|
      if BRACKET_PAIRS.keys.include?(sym)
        brackets_stack.push(sym)
        last_step_opened_bracket = true
        next
      end

      if BRACKET_PAIRS.values.include?(sym)
        last_opened = brackets_stack.pop
        if last_step_opened_bracket || !last_opened || sym != BRACKET_PAIRS[last_opened]
          fail(record)
          return
        end
      end

      last_step_opened_bracket = false
    end

    fail(record) unless brackets_stack.empty?
  end

  private

  def fail(record)
    record.errors[:title] << 'Brackets are malformed'
  end
end