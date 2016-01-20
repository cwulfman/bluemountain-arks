require 'nokogiri'
require 'ezid-client'
require 'ezid/test_helper'
require 'csv'

Ezid::Client.configure do |config|
  config.user = TEST_USER
  config.password = "apitest"
  config.default_shoulder = TEST_ARK_SHOULDER
end


class TreeWalker
  attr_accessor :path, :table
  def initialize(args={})
    @path = args[:path]
    @table = []
  end

  def walk
    _walk(@path)
  end

  def _walk(start)
    Dir.foreach(start) do |x|
      path = File.join(start, x)
      if x == "." or x == ".."
        next
      elsif File.directory?(path)
        # puts path + "/" # remove this line if you want; just prints directories
        self._walk(path)
      else
        self.process_file(path) if path.end_with?(".mets.xml")
      end
    end
  end

  def process_file(f)
    doc = Nokogiri::XML(File.open(f))
    
    issueid = doc.xpath('//mods:identifier[@type="bmtn"]/text()', 'mods' => 'http://www.loc.gov/mods/v3')
    titleid  = doc.xpath('//mods:relatedItem[@type="host"]/@xlink:href',
                         {
                           'mods' => 'http://www.loc.gov/mods/v3',
                           'xlink' => 'http://www.w3.org/1999/xlink'
                         })
    target = "http://bluemountain.princeton.edu/issue.html?titleURN=#{titleid}&issueURN=#{issueid}"

    identifier = Ezid::Identifier.create
    identifier.target = target
    identifier.save
    @table.push({file: f, target: target, identifier: identifier})
  end 

  def to_csv
    
  end

end
