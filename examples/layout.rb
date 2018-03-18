# frozen_string_literal: true

require 'interphase'
include Interphase

window = Window.new('Layout') do
  quit_on_delete!

  add Layout.new('
  aaaaa
  bcccd
  ') do
    p description
    self['a'] = Button.new('A!')
    self['b'] = Button.new('B!')
    self['c'] = Button.new('C!')
    self['d'] = Button.new('D!')
  end
end

window.show_all
window.run
