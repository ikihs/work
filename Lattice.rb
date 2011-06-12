#!ruby -Ku

module Lattice

  def g_size(c,d)
    d.push(c).transpose.map{|i|i.map(&:size).max}
  end

  def g_line(s)
    "+#{s.map{|i|"-"*(i+2)}*"+"}+"
  end

  def g_data(d,s,i)
    d.map{|x|"| #{x.zip(s,i).map{|x,y,z|(x||z).to_s.ljust(y)}*" | "} |"}
  end

  def lattice(a)
    line = g_line(a["size"])
    col  = g_data([a["col"]],a["size"],a["ini"])
    data = g_data(a["data"],a["size"],a["ini"])
#    data = data - [line.gsub("+","|").gsub("-"," ")]
    [line,col,line,data,line].flatten
  end

  def resize_column(h)
    col = []
    h.flatten.each_slice(2){|i,j|col << [i,j.to_s.size]}
    col = col.group_by{|i|i[0]}.map{|j|j[1].max_by{|k|k[1]}}
    col = col.map{|x,y|[x,(y<x.size) ? x.size : y]}
  end

  def lat_grouping a
    a[0..2]+a[3..-2].group_by{|i|i.split[1]}.sort.map{|k,v|[v,a[0]]}.flatten
  end

  def lat_merge *a
    a[0][0..2]+a.reduce([]){|i,j|i+j[3..-2]}+[a[0][-1]]
  end

end


