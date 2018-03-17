# frozen_string_literal: true

require 'interphase'
include Interphase

window = Window.new('Grid') do
  quit_on_delete!

  add Grid.new(2, 2) do
    add Label.new('test'), 0, 1, 0, 1
    add Label.new('test 2'), 1, 2, 1, 2
  end
end

window.show_all
window.run
