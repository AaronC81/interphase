# frozen_string_literal: true

require 'interphase'
include Interphase

window = Window.new('Numbers') do
  add HBox.new do
    10.times do |i|
      add Button.new(i.to_s), false, false, 10 do
        size 50, 50
        on_click do
          puts "You have clicked #{i}"
        end
      end
    end
  end
end

window.show_all
window.run
