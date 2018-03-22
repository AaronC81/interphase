# frozen_string_literal: true

require 'interphase'
include Interphase

window = Window.new('Scrolling') do
  quit_on_delete!
  size 200, 200

  add ScrollingTransformer.new(SimpleListView.new(('a'..'z').to_a))
end

window.show_all
window.run
