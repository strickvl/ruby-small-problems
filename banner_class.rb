class Banner
  PADDING = 4
  
  def initialize(message, width=message.size)
    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    @width = @message.size if @width < @message.size
    "+-" + ("-"*(@width)) + "-+"
  end

  def empty_line
    "| " + (" "*(@width)) + " |"
  end

  def message_line
    if @width>= @message.size
      centred_message = @message.center(@width + PADDING)
      centred_message[0], centred_message[-1] = "|", "|"
      return centred_message
    elsif @width < @message.size
      "| #{@message} |"
    end
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end

banner = Banner.new('')
puts banner
=begin
+--+
|  |
|  |
|  |
+--+
=end

banner = Banner.new('To boldly go where no one has gone before.', 60)
puts banner
=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end
