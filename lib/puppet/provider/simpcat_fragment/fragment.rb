Puppet::Type.type(:simpcat_fragment).provide :simpcat_fragment do
  require 'fileutils'

  desc "simpcat_fragment provider"

  def create

    begin
      if @resource[:externally_managed] == :true then
        FileUtils.touch("#{Puppet[:vardir]}/simpcat/fragments/#{@resource[:group]}/#{@resource[:fragment]}")
      else
        fh = File.open("#{Puppet[:vardir]}/simpcat/fragments/#{@resource[:group]}/#{@resource[:fragment]}", "w")
        fh.puts @resource[:content]
        fh.close
      end

    rescue Exception => e
      fail Puppet::Error, e
    end
  end

  def register
    begin
      FileUtils.mkdir_p("#{Puppet[:vardir]}/simpcat/fragments/#{@resource[:group]}")

      frags_record = "#{Puppet[:vardir]}/simpcat/fragments/#{@resource[:group]}/.~simpcat_fragments"
      fh = File.open(frags_record,'a')
      fh.puts(@resource[:fragment])
      fh.close

    rescue Exception => e
      fail Puppet::Error, e
    end

  end

end
