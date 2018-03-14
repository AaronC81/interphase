# frozen_string_literal: true

describe Interphase::ListView do
  let(:subject) { ListView.new(['Column A', 'Column B']) }
  let(:mock_row) { ['Row 1 A', 'Row 1 B'] }

  it 'is empty upon initialization' do
    expect(subject.rows.length).to eq 0
  end

  it 'can have rows added' do
    subject.rows << mock_row
    expect(subject.rows.length).to eq 1
    expect(subject.rows[0]).to eq mock_row
  end

  it 'calls #refresh_rows upon row modifications' do
    refreshed = false
    allow(subject).to receive(:refresh_rows) do
      refreshed = true
    end

    subject.rows << mock_row

    expect(refreshed).to be true
  end
end
