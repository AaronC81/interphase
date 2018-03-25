# frozen_string_literal: true

# TODO: This test is very bad.

describe Interphase::Transformer do
  let(:transformed_widget) do
    widget = Label.new('')
    t1 = Transformer.new(widget, widget.gtk_instance)

    Transformer.new(t1, t1.gtk_instance)
  end

  it 'modifies #transformers' do
    expect(transformed_widget.transformers.length).to eq(2)
  end

  context 'inside containers' do
    it 'persists through name lookups' do
      window = Window.new('') do
        widget = Label.new('', name: 'x')
        t1 = Transformer.new(widget, widget.gtk_instance)

        add Transformer.new(t1, t1.gtk_instance)
      end

      expect(window.x.transformers.length).to eq(2)
    end
  end
end
