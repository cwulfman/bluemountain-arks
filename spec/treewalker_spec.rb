require 'spec_helper'

test_path = '/Users/cwulfman/repos/github/cwulfman/BlueMountain/metadata/periodicals/bmtnaap/issues/1921'

describe 'TreeWalker' do
  # describe '#path' do
  #   it "has a proper path" do
  #     tw = TreeWalker.new(path: test_path)
  #     expect(tw.path).to eq(test_path)
  #     expect(File.directory?(tw.path)).to be_true
  #   end
  # end

  # describe "#walk" do
  #   it 'puts data in table' do
  #     tw = TreeWalker.new(path: test_path)
  #     tw.walk
  #     expect(tw.table).not_to be_empty
  #   end

  #   it 'creates a proper table entry' do
  #     tw = TreeWalker.new(path: test_path)
  #     tw.walk
  #     first_entry = tw.table[0]
  #     expect(first_entry[:file]).to eq("/Users/cwulfman/repos/github/cwulfman/BlueMountain/metadata/periodicals/bmtnaap/issues/1921/11_01/bmtnaap_1921-11_01.mets.xml")
  #     expect(first_entry[:target]).to eq("http://bluemountain.princeton.edu/issue.html?titleURN=urn:PUL:bluemountain:bmtnaap&issueURN=urn:PUL:bluemountain:bmtnaap_1921-11_01")
  #   end
  # end

  describe "to_csv" do
    it "writes to /tmp/arks.csv" do
      tw = TreeWalker.new(path: test_path)
      tw.walk
      tw.to_csv
    end
  end
end
