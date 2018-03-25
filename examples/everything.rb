# frozen_string_literal: true

# This example showcases almost every control which Interphase has, in a rather
# disorganised manner.

require 'interphase'
include Interphase

window = Window.new('Hello, world') do
  size 800, 600

  add VBox.new do
    add Label.new 'This is a label'
    add ListView.new(['Column 1', 'Column 2']) do
      rows << %w[A B]
      rows << %w[C D]
    end
    add SimpleListView.new(['Item 1', 'Item 2', 'Item 3'])
    add Fixed.new do
      add Label.new('Wow, a label'), 0, 0
      add Label.new('Another label in a different place'), 100, 100
    end
    add SimpleStatusBar.new(name: 'status_bar'), false, false
    add Button.new('CLICK ME!', name: 'button') do
      on_click do
        puts 'I have been clicked'
      end
    end
  end

  in_background do
    count = 0
    loop do
      window.status_bar.text = "This program has been running for #{count}s."
      sleep(1)
      count += 1
    end
  end
end

window.button.click

window.show_all
window.run
