# frozen_string_literal: true

require 'interphase'
include Interphase

window = Window.new('List View') do
  quit_on_delete!

  add ListView.new(%w[Name Age]) do
    rows << %w[Aaron 17]
    rows << %w[Bob 18]

    on_select do |arg|
      p arg
    end
  end
end

window.show_all
window.run
