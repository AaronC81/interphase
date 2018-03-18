# frozen_string_literal: true

require 'interphase'
include Interphase

window = Window.new('Layout') do
  quit_on_delete!

  add Layout.new('
    =====
    <###>
    <###>
    <###>
  ') do
    self['='] = Button.new('Top bar')
    self['<'] = Button.new('Left sidebar')
    self['#'] = Button.new('Content')
    self['>'] = Button.new('Right sidebar')
  end
end

window.show_all
window.run
