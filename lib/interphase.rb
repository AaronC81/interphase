# frozen_string_literal: true

require 'gtk2'

require 'interphase/helpers/observable'
require 'interphase/helpers/layout_parser'

require 'interphase/transformers/transformer'
require 'interphase/transformers/scrolling_transformer'

require 'interphase/widgets/basic_widgets'
require 'interphase/widgets/window'
require 'interphase/widgets/label'
require 'interphase/widgets/box'
require 'interphase/widgets/status_bar'
require 'interphase/widgets/list_view'
require 'interphase/widgets/simple_list_view'
require 'interphase/widgets/fixed'
require 'interphase/widgets/dialog'
require 'interphase/widgets/button'
require 'interphase/widgets/entry'
require 'interphase/widgets/grid'
require 'interphase/widgets/layout'

require 'interphase/extras/status_icon'
require 'interphase/extras/stock_icon'

module Interphase
  # Runs the entire Interphase application.
  def run
    Gtk.main
  end
end
